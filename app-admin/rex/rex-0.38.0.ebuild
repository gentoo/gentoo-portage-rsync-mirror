# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rex/rex-0.38.0.ebuild,v 1.1 2013/01/29 03:29:22 patrick Exp $

EAPI=4

MODULE_AUTHOR=JFRIED
MODULE_VERSION=${PV}
MY_P="Rex-${MODULE_VERSION}"
inherit perl-module

DESCRIPTION="(R)?ex is a small script to ease the execution of remote commands."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Net-SSH2"
DEPEND="${RDEPEND}
	dev-perl/JSON-XS
	dev-perl/XML-Simple
	dev-perl/Digest-SHA1
	dev-perl/Digest-HMAC
	dev-perl/Expect
	dev-perl/DBI
	dev-perl/yaml
	dev-perl/libwww-perl"

SRC_TEST="do"
