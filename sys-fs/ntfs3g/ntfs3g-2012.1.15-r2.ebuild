# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ntfs3g/ntfs3g-2012.1.15-r2.ebuild,v 1.8 2012/12/30 14:59:47 ago Exp $

EAPI=5
inherit eutils linux-info udev

MY_PN=${PN/3g/-3g}
MY_P=${MY_PN}_ntfsprogs-${PV}

DESCRIPTION="Open source read-write NTFS driver that runs under FUSE"
HOMEPAGE="http://www.tuxera.com/community/ntfs-3g-download/"
SRC_URI="http://tuxera.com/opensource/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="acl crypt debug +external-fuse +ntfsprogs static-libs suid xattr"

RDEPEND="!<sys-apps/util-linux-2.20.1-r2
	!sys-fs/ntfsprogs
	crypt? (
		>=dev-libs/libgcrypt-1.2.2
		>=net-libs/gnutls-1.4.4
		)
	external-fuse? ( >=sys-fs/fuse-2.8.0 )"
DEPEND="${RDEPEND}
	sys-apps/attr
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS ChangeLog CREDITS README"

pkg_setup() {
	if use external-fuse && use kernel_linux; then
		if kernel_is lt 2 6 9; then
			die "Your kernel is too old."
		fi
		CONFIG_CHECK="~FUSE_FS"
		FUSE_FS_WARNING="You need to have FUSE module built to use ntfs-3g"
		linux-info_pkg_setup
	fi
}

src_configure() {
	econf \
		--exec-prefix="${EPREFIX}"/usr \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_enable debug) \
		--enable-ldscript \
		--disable-ldconfig \
		$(use_enable acl posix-acls) \
		$(use_enable xattr xattr-mappings) \
		$(use_enable crypt crypto) \
		$(use_enable ntfsprogs) \
		--enable-extras \
		$(use_enable static-libs static) \
		--with-fuse=$(usex external-fuse external internal)
}

src_install() {
	default

	use suid && fperms u+s /usr/bin/${MY_PN}
	udev_dorules "${FILESDIR}"/99-ntfs3g.rules
	prune_libtool_files

	# http://bugs.gentoo.org/398069
	dodir /usr/sbin
	mv "${ED}"/sbin/* "${ED}"/usr/sbin || die
	rm -r "${ED}"/sbin

	dosym mount.ntfs-3g /usr/sbin/mount.ntfs #374197
}
