# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udisks/udisks-2.0.91.ebuild,v 1.2 2013/01/19 15:53:57 ssuominen Exp $

EAPI=5
inherit bash-completion-r1 eutils linux-info systemd

DESCRIPTION="Daemon providing interfaces to work with storage devices"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/udisks"
SRC_URI="http://udisks.freedesktop.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug crypt +gptfdisk +introspection selinux systemd"

UDEV_VERSION="197"
COMMON_DEPEND=">=dev-libs/glib-2.32
	>=dev-libs/libatasmart-0.19
	>=sys-auth/polkit-0.110
	virtual/acl
	>=virtual/udev-${UDEV_VERSION}[gudev,hwdb]
	introspection? ( >=dev-libs/gobject-introspection-1.30 )
	selinux? ( sec-policy/selinux-devicekit )
	systemd? ( >=sys-apps/systemd-${UDEV_VERSION} )"
# gptfdisk -> src/udiskslinuxpartition.c -> sgdisk (see also #412801#c1)
# util-linux -> mount, umount, swapon, swapoff (see also #403073)
RDEPEND="${COMMON_DEPEND}
	>=sys-apps/util-linux-2.20.1-r2
	>=sys-block/parted-3
	virtual/eject
	crypt? ( sys-fs/cryptsetup )
	gptfdisk? ( >=sys-apps/gptfdisk-0.8 )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	>=dev-util/gdbus-codegen-2.32
	dev-util/intltool
	>=sys-kernel/linux-headers-3.1
	virtual/pkgconfig"

DOCS="AUTHORS HACKING NEWS README"

pkg_setup() {
	# Listing only major arch's here to avoid tracking kernel's defconfig
	if use amd64 || use arm || use ppc || use ppc64 || use x86; then
		CONFIG_CHECK="~!IDE" #319829
		CONFIG_CHECK+=" ~TMPFS_POSIX_ACL" #412377
		CONFIG_CHECK+=" ~USB_SUSPEND" #331065
		CONFIG_CHECK+=" ~SWAP" # http://forums.gentoo.org/viewtopic-t-923640.html
		CONFIG_CHECK+=" ~NLS_UTF8" #425562
		linux-info_pkg_setup
	fi
}

src_prepare() {
	use systemd || { sed -i -e 's:libsystemd-login:&disable:' configure || die; }
}

src_configure() {
	econf \
		--localstatedir="${EPREFIX}"/var \
		--disable-static \
		$(use_enable debug) \
		--disable-gtk-doc \
		$(use_enable introspection) \
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html \
		"$(systemd_with_unitdir)"
}

src_install() {
	default
	prune_libtool_files
	keepdir /var/lib/udisks2 #383091

	rm -rf "${ED}"/usr/share/bash-completion
	dobashcomp data/completions/udisksctl

	local htmldir=udisks2
	if [[ -d ${ED}/usr/share/doc/${PF}/html/${htmldir} ]]; then
		dosym /usr/share/doc/${PF}/html/${htmldir} /usr/share/gtk-doc/html/${htmldir}
	fi
}

pkg_postinst() {
	mkdir -p "${EROOT}"/run #415987

	# See pkg_postinst() of >=sys-apps/baselayout-2.1-r1. Keep in sync?
	if ! grep -qs "^tmpfs.*/run " "${EROOT}"/proc/mounts ; then
		echo
		ewarn "You should reboot the system now to get /run mounted with tmpfs!"
	fi
}
