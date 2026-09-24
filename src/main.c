#include <stdio.h>
#include <stdlib.h>
#include "myfilefunctions.h"

int main()
{
    FILE* file;
    int lines;
    int words;
    int chars;

    file = fopen("test.txt", "r");

    if (file == NULL)
    {
        printf("Could not open file.\n");
        return 1;
    }

    if (wordCount(file, &lines, &words, &chars) == 0)
    {
        printf("Lines: %d\n", lines);
        printf("Words: %d\n", words);
        printf("Characters: %d\n", chars);
    }

    fclose(file);

    file = fopen("test.txt", "r");

    if (file == NULL)
    {
        printf("Could not open file.\n");
        return 1;
    }

    char** matches;

    int count = mygrep(file, "Hello", &matches);

    printf("\nMatching lines: %d\n", count);

    for (int i = 0; i < count; i++)
    {
        printf("%s", matches[i]);
        free(matches[i]);
    }

    free(matches);
    fclose(file);

    return 0;
}
