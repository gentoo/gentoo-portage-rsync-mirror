# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia-cg-toolkit/nvidia-cg-toolkit-2.1.0012.ebuild,v 1.8 2012/11/28 20:32:24 jlec Exp $

inherit versionator

MY_PV="$(get_version_component_range 1-2)"
MY_DATE="October2008"

DESCRIPTION="nvidia's c graphics compiler toolkit"
HOMEPAGE="http://developer.nvidia.com/object/cg_toolkit.html"
SRC_URI="
	x86? ( http://developer.download.nvidia.com/cg/Cg_2.0/${PV}/Cg-${MY_PV}_${MY_DATE}_x86.tgz )
	amd64? ( http://developer.download.nvidia.com/cg/Cg_2.0/${PV}/Cg-${MY_PV}_${MY_DATE}_x86_64.tgz )"

SLOT="0"
LICENSE="NVIDIA"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT="strip"

RDEPEND="media-libs/freeglut"
DEPEND=""

S="${WORKDIR}"

src_install() {
	dobin usr/bin/cgc || die

	if use x86; then
		dolib usr/lib/* || die
	elif use amd64; then
		dolib usr/lib64/* || die
	fi

	doenvd "${FILESDIR}"/80cgc || die

	insinto /usr/include/Cg
	doins usr/include/Cg/* || die

	doman usr/share/man/man3/* || die

	dodoc usr/local/Cg/MANIFEST usr/local/Cg/README \
	      usr/local/Cg/docs/*.pdf usr/local/Cg/docs/CgReferenceManual.chm || die

	docinto html
	dohtml usr/local/Cg/docs/html/* || die

	# Copy all the example code.
	dodir /usr/share/doc/${PF}/
	mv usr/local/Cg/examples "${D}"/usr/share/doc/${PF}/

	docinto include/GL
	dodoc usr/local/Cg/include/GL/* || die
}
