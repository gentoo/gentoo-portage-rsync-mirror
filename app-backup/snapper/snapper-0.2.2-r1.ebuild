# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/snapper/snapper-0.2.2-r1.ebuild,v 1.1 2014/05/22 09:56:05 dlan Exp $

EAPI=5

inherit eutils

DESCRIPTION="Command-line program for btrfs and ext4 snapshot management"
HOMEPAGE="http://snapper.io/"
SRC_URI="ftp://ftp.suse.com/pub/projects/snapper/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+btrfs ext4 lvm pam xattr"

RDEPEND="dev-libs/boost[threads]
	dev-libs/libxml2
	dev-libs/icu
	sys-apps/acl
	sys-apps/dbus
	sys-apps/util-linux
	sys-libs/zlib
	virtual/libintl
	btrfs? ( sys-fs/btrfs-progs )
	ext4? ( sys-fs/e2fsprogs )
	lvm? ( sys-fs/lvm2 )
	pam? ( sys-libs/pam )
	xattr? ( sys-apps/attr )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig"

DOCS=( AUTHORS README )

src_prepare() {
	epatch "${FILESDIR}"/cron-confd.patch
}

src_configure() {
	econf  \
	--with-conf="/etc/conf.d" \
	--docdir="/usr/share/doc/${PF}" \
	$(use_enable btrfs) \
	$(use_enable ext4) \
	$(use_enable lvm) \
	$(use_enable pam) \
	$(use_enable xattr xattrs) \
	--disable-zypp
}

src_install() {
	default
	# Existing configuration file required to function
	newconfd data/sysconfig.snapper snapper
	prune_libtool_files
}

pkg_postinst() {
	elog "In order to use Snapper, you need to set up at least one config"
	elog "manually, or else the tool will get confused. Typically you should"
	elog "create a '/.snapshots' directory, then copy the file"
	elog "'/etc/snapper/config-templates/default' into '/etc/snapper/configs/',"
	elog "rename the file to 'root', and add its name into '/etc/conf.d/snapper'."
	elog "That will instruct Snapper to snapshot the root of the filesystem by"
	elog "default. For more information, see the snapper(8) manual page."
}
