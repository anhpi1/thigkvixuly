#include <stdio.h>
#include <stdint.h>

uint8_t getstring[10] = {10 , 0, 0, 0, 0, 0, 0, 0, 0, 0};
     
uint8_t ARR[8] = {0};
uint8_t groupA[4] = {0,0,0,9};
uint8_t groupB[4] = {0,0,0,9};
uint8_t groupC[4] = {0,0,0,9};
uint8_t errorA[] = " no element in groupA $";
uint8_t errorB[] = " no element in groupB $";
uint8_t errorC[] = " no element in groupC $";
                     
uint8_t decIntUser[10] = {10 , 0, 0, 0, 0, 0, 0, 0, 0, 0};
uint8_t cTemp[10] = {0};
uint8_t cPrint[10] = {0};


void mygets(uint8_t *inputBuffer);
void convertCharToInt(uint8_t *inputBuffer, uint8_t *outputBuffer, uint8_t maxLen);
void joinGroups(uint8_t *inputBuffer, uint8_t *inputgroupA, uint8_t *inputgroupB, uint8_t *inputgroupC, uint8_t maxLen);
void printGroups(uint8_t *groupA, uint8_t *groupB, uint8_t *groupC);

int main()
{
    mygets(getstring);
    convertCharToInt(getstring, ARR, getstring[1]);
    joinGroups(ARR, groupA, groupB, groupC, getstring[1]);

    printGroups(groupA, groupB, groupC);

    return 0;
}

void mygets(uint8_t *inputBuffer)
{
    uint8_t max_len = inputBuffer[0];   //tối đa 10 ký tự
    uint8_t count = 0;
    uint8_t ch;

    while (count < max_len)
    {
        ch = getchar();
        if (ch == '\n') break;
        inputBuffer[2 + count] = ch;    //lưu ký tự
        count++;
    }

    inputBuffer[1] = count;             //cập nhật số ký tự thực tế
    inputBuffer[2 + count] = '\0';
}

void convertCharToInt(uint8_t *inputBuffer, uint8_t *outputBuffer, uint8_t maxLen)
{
    for (uint8_t i = 0; i < maxLen; i++)
    {
        uint8_t ch = inputBuffer[2 + i];
        if (ch >= '0' && ch <= '9')
            outputBuffer[i] = ch - '0';
        else
            outputBuffer[i] = 0;
    }
}


void joinGroups(uint8_t *inputBuffer, uint8_t *inputgroupA, uint8_t *inputgroupB, uint8_t *inputgroupC, uint8_t maxLen)
{
    for (uint8_t i = 0; i < maxLen; i++)
    {
        uint8_t v = inputBuffer[i];
        if (v == 0) continue;     //bỏ ký tự rỗng

        uint8_t *g = 0;           //con trỏ trỏ vào group cần ghi

        //nhóm A: chia hết cho 3
        if (v % 3 == 0)
            g = inputgroupA;

        //nhóm B: lẻ và không chia hết 3
        else if (v % 2 == 1)
            g = inputgroupB;

        //nhóm C: chẵn và không chia hết 3
        else
            g = inputgroupC;

        //cập nhật group

        //tăng số lượng
        g[0]++;

        //cộng vào tổng
        g[1] += v;

        //cập nhật giá trị lớn nhất
        if (v > g[2])
            g[2] = v;
        //cập nhật giá trị nhỏ nhất
        if (v < g[3])
            g[3] = v;
    }
}

void printGroups(uint8_t *groupA, uint8_t *groupB, uint8_t *groupC)
{
    //group A
    if (groupA[0] == 0)
        printf("%s ", errorA);
    else
        printf("%d %d %d %d ", groupA[0], groupA[1], groupA[2], groupA[3]);

    //group B
    if (groupB[0] == 0)
        printf("%s ", errorB);
    else
        printf("%d %d %d %d ", groupB[0], groupB[1], groupB[2], groupB[3]);

    //group C
    if (groupC[0] == 0)
        printf("%s", errorC);
    else
        printf("%d %d %d %d", groupC[0], groupC[1], groupC[2], groupC[3]);

    printf("\n"); 
}