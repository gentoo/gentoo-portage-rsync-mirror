# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/testdisk/testdisk-6.14.ebuild,v 1.2 2014/12/30 19:51:44 maekke Exp $

EAPI=5

inherit eutils flag-o-matic

DESCRIPTION="Checks and undeletes partitions + PhotoRec, signature based recovery tool"
HOMEPAGE="http://www.cgsecurity.org/wiki/TestDisk"
SRC_URI="http://www.cgsecurity.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="jpeg ntfs reiserfs static"

# WARNING: reiserfs support does NOT work with reiserfsprogs
# you MUST use progsreiserfs-0.3.1_rc8 (the last version ever released).
DEPEND="
		sys-apps/util-linux
		>=sys-libs/ncurses-5.2
		jpeg? ( virtual/jpeg )
		ntfs? ( sys-fs/ntfs3g )
		reiserfs? ( >=sys-fs/progsreiserfs-0.3.1_rc8 )
		>=sys-fs/e2fsprogs-1.35
		sys-libs/zlib"
RDEPEND="!static? ( ${DEPEND} )"

src_configure() {
	local myconf

	# this is static method is the same used by upstream for their 'static' make
	# target, but better, as it doesn't break.
	use static && append-ldflags -static

	# --with-foo are broken, any use of --with/--without disable the
	# functionality.
	# The following variation must be used.
	use reiserfs || myconf+=" --without-reiserfs"
	use ntfs || myconf+=" --without-ntfs"
	use jpeg || myconf+=" --without-jpeg"

	econf \
		--docdir="${ED}/usr/share/doc/${PF}" \
		--without-ewf \
		--enable-sudo \
		${myconf}

	# perform safety checks for NTFS, REISERFS and JPEG
	if use ntfs && ! egrep -q '^#define HAVE_LIBNTFS(3G)? 1$' "${S}"/config.h ; then
		die "Failed to find either NTFS or NTFS-3G library."
	fi
	if use reiserfs && egrep -q 'undef HAVE_LIBREISERFS\>' "${S}"/config.h ; then
		die "Failed to find reiserfs library."
	fi
	if use jpeg && egrep -q 'undef HAVE_LIBJPEG\>' "${S}"/config.h ; then
		die "Failed to find jpeg library."
	fi
}
