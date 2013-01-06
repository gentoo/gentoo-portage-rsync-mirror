# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/noegnud-slashem/noegnud-slashem-0.8.2.ebuild,v 1.12 2011/02/24 14:46:03 tupone Exp $

inherit eutils games

VAR_NAME=slashem
VAR_SNAME=se
VAR_DVER=0.0.7E3
VAR_VER=007e3
VAR_TAR=${VAR_SNAME}${VAR_VER}.tar.gz
DESCRIPTION="an alternate 2D/3D graphical user interface for SLASH'EM"
HOMEPAGE="http://noegnud.sourceforge.net/"
SRC_URI="mirror://sourceforge/noegnud/noegnud-${PV}_linux_src-minimal.tar.bz2
	mirror://sourceforge/noegnud/noegnud-${PV}_noegnud-${PV}.se${VAR_VER/e/E}.diff.gz
	mirror://sourceforge/${VAR_NAME}/${VAR_TAR}"

LICENSE="nethack"
SLOT="0"
KEYWORDS="ppc x86"
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
	cd noegnud-${PV}
	epatch "${DISTDIR}"/noegnud-${PV}_noegnud-${PV}.${VAR_SNAME}${VAR_VER/e/E}.diff.gz
	ln -s "${DISTDIR}"/${VAR_TAR} variants/tarballs/${VAR_TAR}
	epatch "${FILESDIR}/${P}"-gcc41.patch
	cd variants
	make noegnud-0.8.0-${VAR_NAME}-${VAR_DVER}
	epatch "${FILESDIR}"/${P}-ldflags.patch
	sed -i -e 's:$(LFLAGS):$(LDFLAGS) $(LFLAGS):' \
		slashem-0.0.7E3/sys/unix/Makefile.utl || die "sed failed"
}

src_compile() {
	emake ${VAR_SNAME}${VAR_VER} PREFIX="${GAMES_PREFIX}" || die
}

src_install() {
	emake install_${VAR_SNAME}${VAR_VER} PREFIX="${D}/${GAMES_PREFIX}" || die

	cd "${D}/${GAMES_BINDIR}"
	# we do this cause sometimes the installed package thinks it's a diff version :)
	local tver=$(ls noegnud-*-${VAR_NAME}-${VAR_DVER} | cut -d- -f2)
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
