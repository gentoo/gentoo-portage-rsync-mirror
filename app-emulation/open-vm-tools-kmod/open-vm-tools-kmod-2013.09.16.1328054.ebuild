# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/open-vm-tools-kmod/open-vm-tools-kmod-2013.09.16.1328054.ebuild,v 1.1 2013/10/19 01:42:17 floppym Exp $

EAPI="5"

inherit eutils linux-mod versionator

MY_PN="${PN/-kmod}"
MY_PV="$(replace_version_separator 3 '-')"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Opensourced tools for VMware guests"
HOMEPAGE="http://open-vm-tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CONFIG_CHECK="
	~DRM_VMWGFX
	~VMWARE_BALLOON
	~VMWARE_PVSCSI
	~VMXNET3
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/frozen.patch"
	epatch "${FILESDIR}/putname.patch"
	epatch_user
}

src_configure() {
	export OVT_SOURCE_DIR="${S}"
	export LINUXINCLUDE="${KV_OUT_DIR}/include"

	# See logic in configure.ac.
	local MODULES="vmxnet vmhgfs"
	kernel_is -lt 3 9 && MODULES+=" vmci vsock"
	kernel_is -lt 3 && MODULES+=" vmblock vmsync"

	local mod
	for mod in ${MODULES}; do
		MODULE_NAMES+=" ${mod}(ovt:modules/linux/${mod})"
	done

	BUILD_TARGETS="auto-build"
}

src_install() {
	linux-mod_src_install

	local udevrules="${T}/60-vmware.rules"
	cat > "${udevrules}" <<-EOF
		KERNEL=="vsock", GROUP="vmware", MODE=660
	EOF
	insinto /lib/udev/rules.d/
	doins "${udevrules}"
}
