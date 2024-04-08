from dotenv import load_dotenv


def main() -> None:
    load_dotenv(dotenv_path=".env", override=True)

    print("hello world")


if __name__ == "__main__":
    main()
