# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bub-n-bros/bub-n-bros-1.6.ebuild,v 1.7 2010/09/09 17:35:20 mr_bones_ Exp $

EAPI=2
PYTHON_DEPEND="2"
inherit eutils python games

MY_P=${P/-n-}
DESCRIPTION="A multiplayer clone of the famous Bubble Bobble game"
HOMEPAGE="http://bub-n-bros.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-python/pygame"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	ecvs_clean
	epatch \
		"${FILESDIR}"/${P}-home.patch \
		"${FILESDIR}"/${P}-python25.patch
	python_convert_shebangs -r 2 .
}

src_compile() {
	# Compile the "statesaver" extension module to enable the Clock bonus
	cd "${S}"/bubbob
	$(PYTHON) setup.py build_ext -i || die

	# Compile the extension module required for the X Window client
	cd "${S}"/display
	$(PYTHON) setup.py build_ext -i || die

	# Build images
	cd "${S}"/bubbob/images
	$(PYTHON) buildcolors.py || die
}

src_install() {
	local dir=$(games_get_libdir)/${PN}

	exeinto "${dir}"
	doexe *.py || die "doexe failed"

	insinto "${dir}"
	doins -r bubbob common display java http2 metaserver || die "doins failed"

	dodir "${GAMES_BINDIR}"
	dosym "${dir}"/BubBob.py "${GAMES_BINDIR}"/bubnbros || die "dosym failed"

	newicon http2/data/bob.png ${PN}.png
	make_desktop_entry bubnbros Bub-n-Bros

	prepgamesdirs
}
