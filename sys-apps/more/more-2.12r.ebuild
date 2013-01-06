# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/more/more-2.12r.ebuild,v 1.4 2011/07/08 10:59:24 ssuominen Exp $

inherit eutils flag-o-matic

DESCRIPTION="Primitive text file viewer"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"
SRC_URI="mirror://kernel/linux/utils/util-linux/util-linux-${PV}.tar.bz2"
S=${WORKDIR}/util-linux-${PV}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86-fbsd"
IUSE="static nls selinux"

RDEPEND=">=sys-libs/ncurses-5.2-r2
	selinux? ( sys-libs/libselinux )
	!sys-apps/util-linux"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

yesno() { use $1 && echo yes || echo no; }

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-freebsd.patch

	# Enable random features
	local mconfigs="MCONFIG"
	sed -i \
		-e "/^HAVE_SELINUX=/s:no:$(yesno selinux):" \
		-e "/^DISABLE_NLS=/s:no:$(yesno !nls):" \
		-e "/^HAVE_KILL=/s:no:yes:" \
		-e "/^HAVE_SLN=/s:no:yes:" \
		-e "/^HAVE_TSORT/s:no:yes:" \
		-e "s:-pipe -O2 \$(CPUOPT) -fomit-frame-pointer:${CFLAGS}:" \
		-e "s:CPU=.*:CPU=${CHOST%%-*}:" \
		-e "s:SUIDMODE=.*4755:SUIDMODE=4711:" \
		${mconfigs} || die "MCONFIG sed"
}

src_compile() {
	use static && append-ldflags -static
	export CC="$(tc-getCC)"

	econf || die "configure failed"
	emake -C lib xstrncpy.o || die "emake xstrncpy.o failed"
	emake -C text-utils more || die "emake more failed"
}

src_install() {
	exeinto /bin
	doexe text-utils/more || die
	doman text-utils/more.1 || die
	dodoc HISTORY MAINTAINER README VERSION
}
