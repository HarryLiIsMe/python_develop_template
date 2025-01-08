import pytest
from dotenv import load_dotenv


def test_case3() -> None:
    load_dotenv(dotenv_path=".env", override=True)

    print("test case3")
    assert True, "test case3 passed!!!"


def test_case4() -> None:
    load_dotenv(dotenv_path=".env", override=True)

    print("test case4")
    assert False, "test case4 failed!!!"


# if __name__ == '__main__':
#     pytest.main()
