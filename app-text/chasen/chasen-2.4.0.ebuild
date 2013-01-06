# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/chasen/chasen-2.4.0.ebuild,v 1.10 2012/06/09 19:10:36 armin76 Exp $

inherit perl-app

MY_P="${P/_pre/-preview}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Japanese Morphological Analysis System, ChaSen"
HOMEPAGE="http://chasen-legacy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp//chasen-legacy/24693/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="perl"

DEPEND=">=dev-libs/darts-0.31"
RDEPEND="${DEPEND}
	perl? ( !dev-perl/Text-ChaSen )"
PDEPEND=">=app-dicts/ipadic-2.7.0"

src_unpack() {
	unpack ${A}

	if use perl ; then
		cd "${S}"/perl
		sed -i -e '5a"LD" => "g++",' Makefile.PL || die
	fi
}

src_compile() {
	econf || die
	emake || die
	if use perl ; then
		cd "${S}"/perl
		perl-module_src_compile
	fi
}

src_install () {
	einstall || die

	if use perl ; then
		cd "${S}"/perl
		perl-module_src_install
	fi

	cd "${S}"
	dodoc AUTHORS ChangeLog NEWS README
}
