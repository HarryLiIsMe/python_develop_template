import os

from dotenv import load_dotenv


def main() -> None:
    load_dotenv(dotenv_path=".env", override=True)

    project_name = os.getenv("PROJECT_NAME")
    if project_name == None:
        os.abort()

    print("hello world", project_name)


if __name__ == "__main__":
    main()
