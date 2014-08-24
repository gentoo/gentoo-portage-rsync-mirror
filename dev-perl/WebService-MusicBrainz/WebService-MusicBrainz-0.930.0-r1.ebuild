# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WebService-MusicBrainz/WebService-MusicBrainz-0.930.0-r1.ebuild,v 1.1 2014/08/24 02:43:33 axs Exp $

EAPI=5

MODULE_AUTHOR=BFAIST
MODULE_VERSION=0.93
inherit perl-module

DESCRIPTION="Web service API to MusicBrainz database"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="dev-perl/Class-Accessor
	dev-perl/libwww-perl
	dev-perl/URI
	dev-perl/XML-LibXML"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
"

SRC_TEST=online
