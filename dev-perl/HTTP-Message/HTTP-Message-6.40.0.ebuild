# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Message/HTTP-Message-6.40.0.ebuild,v 1.5 2012/12/01 19:04:20 armin76 Exp $

EAPI=4

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.04
inherit perl-module

DESCRIPTION="Base class for Request/Response"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
	virtual/perl-Compress-Raw-Zlib
	>=dev-perl/URI-1.10
	>=virtual/perl-Encode-2.210.0
	>=dev-perl/HTTP-Date-6.0.0
	dev-perl/IO-HTML
	>=dev-perl/Encode-Locale-1.0.0
	>=dev-perl/LWP-MediaTypes-6.0.0
	>=virtual/perl-IO-Compress-2.021
	>=virtual/perl-MIME-Base64-2.1
"
DEPEND="${RDEPEND}"

SRC_TEST=online
