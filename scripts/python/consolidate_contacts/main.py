import json

def main():
    icloud_contact_names = []
    google_contact_names = []

    with open("icloud.json", "r") as infile:
        icloud_contact_names = json.loads(infile.read())

    with open("google.json", "r") as infile:
        google_contact_names = json.loads(infile.read())

    missing_in_google = []
    missing_in_icloud = []

    for icloud_contact in icloud_contact_names:
        if icloud_contact not in google_contact_names:
            missing_in_google.append(icloud_contact)

    for google_contact in google_contact_names:
        if google_contact not in google_contact_names:
            missing_in_icloud.append(google_contact)

    print("num icloud", len(icloud_contact_names))
    print("num google", len(google_contact_names))

    print("num missing in icloud", len(missing_in_icloud))
    print("num missing in google", len(missing_in_google))

    for missed_contact in missing_in_icloud:
        print("Contact", missed_contact, "from Google is not in iCloud")

    for missed_contact in missing_in_google:
        print(missed_contact, missing_in_google)
        print("Contact", missed_contact, "from iCloud is not in Google")

if __name__ == "__main__":
    main()
