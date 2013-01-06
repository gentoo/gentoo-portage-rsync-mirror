# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/zhu3d/zhu3d-4.2.4.ebuild,v 1.4 2012/08/07 04:55:22 bicatali Exp $

EAPI=4
LANGS="cs de es fr zh"

inherit eutils qt4-r2

DESCRIPTION="Interactive 3D mathematical function viewer"
HOMEPAGE="http://sourceforge.net/projects/zhu3d"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="virtual/opengl
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4"
REPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-gold.patch" )

src_prepare() {
	qt4-r2_src_prepare

	local datadir=/usr/share/${PN}
	sed -i \
		-e "s:^SYSDIR=:SYSDIR=${datadir}/system:" \
		-e "s:^TEXDIR=:TEXDIR=${datadir}/textures:" \
		-e "s:^WORKDIR=:WORKDIR=${datadir}/work:" \
		-e "s:^DOCDIR=:DOCDIR=/usr/share/doc/${PF}/html:" \
		${PN}.pri || die "sed zhu3d.pri failed"

	sed -i -e "/# Optimisation/,/# Include/d" zhu3d.pro \
		|| die "optimisation sed failed"
}

src_install() {
	# not working: emake install INSTALL_ROOT="${D}" || die
	dobin zhu3d

	dodoc {readme,src/changelog}.txt
	dohtml doc/*.png doc/${PN}_en.html

	local lang
	for lang in ${LANGS} ; do
		if use linguas_${lang} ; then

			insinto /usr/share/${PN}/system/languages
			doins system/languages/${PN}_${lang}.qm

			if [ -e doc/${PN}_${lang}.html ] ; then
				dohtml doc/${PN}_${lang}.html
			fi
		fi
	done

	insinto /usr/share/${PN}
	doins -r work/textures

	insinto /usr/share/${PN}/work
	doins -r work/*.zhu work/slideshow

	insinto /usr/share/${PN}/system
	doins -r system/*.zhu system/icons

	doicon system/icons/${PN}.png
	make_desktop_entry ${PN} "Zhu3D Function Viewer" ${PN} "Education;Science;Math;Qt"
}
