# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-DAV/HTTP-DAV-0.470.0.ebuild,v 1.4 2012/05/28 16:00:56 armin76 Exp $

EAPI=4

MODULE_AUTHOR=COSIMO
MODULE_VERSION=0.47
inherit perl-module

DESCRIPTION="A WebDAV client library for Perl5"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="
	dev-perl/libwww-perl
	dev-perl/URI
	dev-perl/XML-DOM
"
DEPEND="${RDEPEND}"

SRC_TEST="do"
