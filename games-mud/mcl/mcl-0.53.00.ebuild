# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/mcl/mcl-0.53.00.ebuild,v 1.21 2010/10/13 21:26:37 mr_bones_ Exp $

EAPI=2
PYTHON_DEPEND="python? 2"
inherit eutils python games

DESCRIPTION="A console MUD client scriptable in Perl and Python"
HOMEPAGE="http://www.andreasen.org/mcl/"
SRC_URI="http://www.andreasen.org/mcl/dist/${P}-src.tar.gz
	mirror://gentoo/${P}-inputlines.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="python perl"

DEPEND="perl? ( dev-lang/perl )"

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-fPIC.patch \
		"${FILESDIR}"/${PV}-vc.patch \
		"${FILESDIR}"/${P}-gcc34.patch \
		"${FILESDIR}"/${PV}-dynacomplete.patch \
		"${FILESDIR}"/${P}-libdir.patch \
		"${WORKDIR}"/${P}-inputlines.patch \
		"${FILESDIR}"/${P}-gcc42.patch \
		"${FILESDIR}"/${P}-glibc2.10.patch

	sed -i \
		-e "/MCL_LIBRARY_PATH/ s:/usr/lib/mcl:$(games_get_libdir)/${PN}:" \
		h/mcl.h \
		|| die "sed h/mcl.h failed"

	# no strip for you
	sed -i \
		-e "/LDFLAGS=.*-s/s:-s::" \
		configure \
		|| die "sed failed"
}

src_configure() {
	egamesconf \
		$(use_enable perl) \
		$(use_enable python)
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc \
		doc/{Changes,Chat,Embedded,Examples,Modules,Plugins,README,TODO} \
		|| die "dodoc failed"
	dohtml doc/*html || die "dohtml failed"
	prepgamesdirs
}
