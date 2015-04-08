# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/gtkada/gtkada-2.8.0.ebuild,v 1.10 2009/08/01 22:56:55 flameeyes Exp $

inherit eutils gnat versionator

Name="GtkAda-gpl"
MajorPV=$(get_version_component_range 1-2)
DESCRIPTION="Gtk+ bindings to the Ada language"
HOMEPAGE="https://libre.adacore.com/GtkAda/"
SRC_URI="mirror://gentoo/${Name}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="nls opengl"

DEPEND="virtual/ada
	>=dev-libs/glib-2.8.0
	>=x11-libs/pango-1.10.0
	>=dev-libs/atk-1.10.0
	>=x11-libs/gtk+-2.8.13
	>=sys-apps/sed-4"
RDEPEND=""

S="${WORKDIR}/${Name}-${PV}"

# only needed for gcc-3.x based gnat profiles, but matching them individually
# would be insane
QA_EXECSTACK="${AdalibLibTop:1}/*/gtkada/libgtkada-${MajorPV}.so.0"

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i -e "s:-aI\$prefix/include/gtkada:-aI${AdalibSpecsDir}/gtkada:" \
		src/gtkada-config.in

	# disable building tests to avoid waisting time while building for every
	# profile. The tests are nonetheless installed under doc dir.
	sed -i -e "/testgtk_dir/d" Makefile.in

	# remove lib stripping
	find src/ -name Makefile.in -exec sed -i -e "/strip/d" {} \;
}

lib_compile() {
	# some profile specific fixes first
	sed -i -e "s:\$prefix/lib\(/gtkada\)*:${AdalibLibTop}/$1/gtkada:" \
		src/gtkada-config.in

	local myconf
	use opengl && myconf="--with-GL=auto" || myconf="--with-GL=no"

	econf ${myconf} $(use_enable nls) || die "./configure failed"

	# bug #279962
	emake -j1 GNATFLAGS="${ADACFLAGS}" || die
}

lib_install() {
	# make install misses all the .so and .a files and otherwise creates more
	# problems than it's worth. Will do everything manually
	mkdir -p ${DL}
	cp src/*.ali src/gtkada-config ${DL}
	find -iname "*.a" -exec mv {} ${DL} \;
	find -iname "*.so*" -exec mv {} ${DL} \;
}

src_install() {
	#set up environment
	echo "PATH=%DL%" > ${LibEnv}
	echo "LDPATH=%DL%" >> ${LibEnv}
	echo "ADA_OBJECTS_PATH=%DL%" >> ${LibEnv}
	echo "ADA_INCLUDE_PATH=${AdalibSpecsDir}/${PN}" >> ${LibEnv}

	gnat_src_install

	#specs
	cd "${S}"/src
	dodir "${AdalibSpecsDir}/${PN}"
	insinto "${AdalibSpecsDir}/${PN}"
	doins *.ad? glade/*.ad? gnome/*.ad? opengl/*.{ad?,c,h}

	#docs
	cd "${S}"
	dodoc ANNOUNCE AUTHORS README
	cp -dPr examples/ testgtk/ "${D}/usr/share/doc/${PF}"
	cd "${S}"/docs
	doinfo gtkada_ug/gtkada_ug.info
	ps2pdf gtkada_ug/gtkada_ug.ps
	ps2pdf gtkada_rm/gtkada_rm.ps
	cp gtkada_ug.pdf gtkada_rm.pdf "${D}/usr/share/doc/${PF}"
	dohtml -r gtkada_ug/{gtkada_ug.html,boxes.gif,hierarchy.jpg}
	cp -dPr gtkada_rm/gtkada_rm/ "${D}/usr/share/doc/${PF}/html"

	# utility stuff
	cd "${S}"
	dodir "${AdalibDataDir}/${PN}"
	insinto "${AdalibDataDir}/${PN}"
	doins -r xml/gtkada.xml projects/
}

pkg_postinst() {
	eselect gnat update
	einfo "The environment has been set up to make gnat automatically find files for"
	einfo "GtkAda. In order to immediately activate these settings please do:"
	einfo "   env-update && source /etc/profile"
	einfo "Otherwise the settings will become active next time you login"
}
