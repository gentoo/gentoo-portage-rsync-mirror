# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-OpenID-Consumer/Net-OpenID-Consumer-1.30.0.ebuild,v 1.1 2011/08/29 11:48:16 tove Exp $

EAPI=4

MODULE_AUTHOR=MART
MODULE_VERSION=1.03
inherit perl-module

DESCRIPTION="Library for consumers of OpenID identities"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/crypt-dh
	dev-perl/XML-Simple
	dev-perl/Digest-SHA1
	dev-perl/libwww-perl
	dev-perl/URI
	dev-perl/URI-Fetch
	virtual/perl-Time-Local
	virtual/perl-MIME-Base64"
DEPEND="${RDEPEND}"

SRC_TEST=do
