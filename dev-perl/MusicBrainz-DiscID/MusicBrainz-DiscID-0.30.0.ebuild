# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MusicBrainz-DiscID/MusicBrainz-DiscID-0.30.0.ebuild,v 1.3 2012/11/25 09:11:35 ssuominen Exp $

EAPI=4

MODULE_AUTHOR=NJH
MODULE_VERSION=0.03
inherit perl-module

DESCRIPTION="Perl interface for the MusicBrainz libdiscid library"
SRC_URI+=" http://dev.gentoo.org/~tove/distfiles/${CATEGORY}/${PN}/${P}-patch.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="test"

RDEPEND=">=media-libs/libdiscid-0.2.2"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	virtual/pkgconfig
	test? (
		dev-perl/Test-Pod
		virtual/perl-Test-Simple
	)
"

SRC_TEST="do"
EPATCH_SUFFIX=patch
PATCHES=(
	"${WORKDIR}"/${MY_PN:-${PN}}-patch
)

src_install() {
	perl-module_src_install

	docinto examples
	dodoc examples/discid.pl
}
