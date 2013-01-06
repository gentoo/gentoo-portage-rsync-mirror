# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/noegnud-nethack/noegnud-nethack-0.8.3.ebuild,v 1.5 2010/12/01 07:52:26 mr_bones_ Exp $

EAPI=2
inherit eutils games

VAR_NAME=nethack
VAR_SNAME=nh
VAR_DVER=3.4.3
VAR_VER=${VAR_DVER//.}
VAR_TAR=${VAR_NAME}-${VAR_VER}-src.tgz
DESCRIPTION="An alternate 2D/3D graphical user interface for NetHack"
HOMEPAGE="http://noegnud.sourceforge.net/"
SRC_URI="mirror://sourceforge/noegnud/noegnud-${PV}_linux_src-minimal.tar.bz2
	mirror://sourceforge/${VAR_NAME}/${VAR_TAR}"

LICENSE="nethack"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	dev-util/yacc"
RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	virtual/opengl
	games-roguelike/noegnud-data"

S=${WORKDIR}/noegnud-${PV}/variants

src_unpack() {
	unpack noegnud-${PV}_linux_src-minimal.tar.bz2
	ln -s "${DISTDIR}"/${VAR_TAR} noegnud-${PV}/variants/tarballs/${VAR_TAR}
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {
	emake ${VAR_SNAME}${VAR_VER} PREFIX="${GAMES_PREFIX}" || die "emake failed"
}

src_install() {
	emake install_${VAR_SNAME}${VAR_VER} PREFIX="${D}/${GAMES_PREFIX}" \
		|| die "emake install failed"

	cd "${D}/${GAMES_BINDIR}"
	# we do this cause sometimes the installed package thinks it's a diff version :)
	local tver="`ls noegnud-*-${VAR_NAME}-${VAR_DVER} | cut -d- -f2`"
	rm noegnud-${VAR_NAME}-${VAR_DVER}
	mv noegnud-${tver}-${VAR_NAME}-${VAR_DVER} noegnud-${VAR_NAME}
	sed -i \
		-e "/^HACKDIR/s:=.*:=$(games_get_libdir)/noegnud-${tver}/${VAR_NAME}-${VAR_DVER}:" \
		noegnud-${VAR_NAME} \
		|| die "sed failed"

	insinto "${GAMES_DATADIR}"/noegnud_data
	doins -r "${S}"/../data/* || die "doins failed"
	dosym "${GAMES_DATADIR}"/noegnud_data "$(games_get_libdir)"/noegnud-${tver}/data

	keepdir "$(games_get_libdir)"/noegnud-${tver}/${VAR_NAME}-${VAR_DVER}/save

	prepgamesdirs
	fperms -R g+w "$(games_get_libdir)"/noegnud-${tver}/${VAR_NAME}-${VAR_DVER}
}
