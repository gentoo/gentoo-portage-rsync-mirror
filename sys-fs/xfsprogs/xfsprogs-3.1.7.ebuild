# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsprogs/xfsprogs-3.1.7.ebuild,v 1.8 2012/04/01 16:41:44 armin76 Exp $

EAPI="3"

inherit eutils toolchain-funcs multilib

DESCRIPTION="xfs filesystem utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/cmd_tars/${P}.tar.gz
	ftp://oss.sgi.com/projects/xfs/previous/cmd_tars/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86"
IUSE="libedit nls readline static static-libs"

RDEPEND="!static? ( >=sys-apps/util-linux-2.17.2 )
	!<sys-fs/xfsdump-3
	readline? (
		sys-libs/readline
		static? ( sys-libs/ncurses )
	)
	!readline? ( libedit? ( dev-libs/libedit ) )"
DEPEND="${RDEPEND}
	static? ( || ( sys-apps/util-linux[static-libs] <sys-apps/util-linux-2.20 ) )
	nls? ( sys-devel/gettext )"

pkg_setup() {
	if use readline && use libedit ; then
		ewarn "You have USE='readline libedit' but these are exclusive."
		ewarn "Defaulting to readline; please disable this USE flag if you want libedit."
	fi

	if use static && use !static-libs ; then
		ewarn "Can't build a static variant of the executables without static-libs."
		ewarn "Static libs will also be built."
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.1.1-sharedlibs.patch

	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		include/builddefs.in || die
	sed -i \
		-e '1iLLDFLAGS = -static' \
		{estimate,fsr}/Makefile || die
	sed -i \
		-e "/LLDFLAGS/s:-static:$(use static && echo -all-static):" \
		$(find -name Makefile) || die

	# libdisk has broken blkid conditional checking
	sed -i \
		-e '/LIB_SUBDIRS/s:libdisk::' \
		Makefile || die

	# TODO: write a patch for configure.in to use pkg-config for the uuid-part
	if use static && use readline ; then
		sed -i \
			-e 's|-lreadline|\0 -lncurses|' \
			-e 's|-lblkid|\0 -luuid|' \
			configure || die
	fi
}

src_configure() {
	export DEBUG=-DNDEBUG
	export OPTIMIZER=${CFLAGS}
	unset PLATFORM # if set in user env, this breaks configure

	local myconf

	if use readline ; then
		myconf="--enable-readline --disable-editline"
	elif use libedit ; then
		myconf="--disable-readline --enable-editline"
	else
		myconf="--disable-readline --disable-editline"
	fi

	if use static || use static-libs ; then
		myconf="${myconf} --enable-static"
	else
		myconf="${myconf} --disable-static"
	fi

	econf \
		--bindir=/usr/bin \
		--libexecdir=/usr/$(get_libdir) \
		$(use_enable nls gettext) \
		${myconf}

	MAKEOPTS+=" V=1"
}

src_install() {
	emake DIST_ROOT="${D}" install install-dev || die
	prepalldocs

	# handle is for xfsdump, the rest for xfsprogs
	gen_usr_ldscript -a xfs xlog
	# removing unnecessary .la files if not needed
	use static-libs || rm -f "${D}"/usr/lib*/*.la
}
