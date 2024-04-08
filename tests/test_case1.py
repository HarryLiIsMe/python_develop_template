import pytest
from dotenv import load_dotenv


def test_case1() -> None:
    load_dotenv(dotenv_path=".env", override=True)

    print("test case1")
    assert True, "test case1 failed!!!"


def test_case2() -> None:
    load_dotenv(dotenv_path=".env", override=True)

    print("test case1")
    assert False, "test case2 failed!!!"


# if __name__ == '__main__':
#     pytest.main()
