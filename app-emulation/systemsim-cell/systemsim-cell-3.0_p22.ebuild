# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/systemsim-cell/systemsim-cell-3.0_p22.ebuild,v 1.1 2008/04/11 17:16:13 corsair Exp $

inherit rpm eutils

DESCRIPTION="Full-System Simulator for the Cell Broadband Engine Processor"
HOMEPAGE="http://www.alphaworks.ibm.com/tech/cellsystemsim"
SRC_URI="x86? ( ${P/_p/-}.i386.rpm )
	ppc64? ( ${P/_p/-}.ppc64.rpm )
	amd64? ( ${P/_p/-}.x86_64.rpm )"

LICENSE="IBM-ILAR"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

SYSTEMSIM_DIR="/opt/ibm/systemsim-cell"
IMAGE_PATH="/usr/share/${PN}/image"

DEPEND="=dev-lang/tcl-8.4*
		=dev-lang/tk-8.4*"

RESTRICT="fetch strip"
S="${WORKDIR}"

pkg_nofetch() {
	einfo "Please download ${A} yourself from:"
	einfo "http://www.alphaworks.ibm.com/tech/cellsystemsim/download"
	einfo "and place it in ${DISTDIR}"
}

src_unpack() {
	rpm_unpack "$DISTDIR"/${A}

	# fix the path to the images. we don't want them in /opt
	sed -i -e "s:\${SYSTEMSIM_TOP}/images:${IMAGE_PATH}:" \
		"${WORKDIR}"/"${SYSTEMSIM_DIR}"/bin/systemsim || die "sed error"
}

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	cp -pPR "${WORKDIR}"/opt "${D}"
	rm -fR "${D}"/"${SYSTEMSIM_DIR}"/doc
	rm -fR "${D}"/"${SYSTEMSIM_DIR}"/images
	insinto /usr/share/doc/"${PF}"/
	doins "${WORKDIR}"/"${SYSTEMSIM_DIR}"/doc/*.pdf
	doenvd "${FILESDIR}"/09systemsim-cell
	dodir "${IMAGE_PATH}"/cell
	echo "Put a system image with the name 'sysroot_disk' and a kernel image\n" \
		"with the name 'vmlinux' here" > "${D}"/"${IMAGE_PATH}"/cell/README
}

pkg_postinst() {
	elog "The provided systemsim doesn't have kernel and system images, please"
	elog "install them in ${IMAGE_PATH}/cell"
}
