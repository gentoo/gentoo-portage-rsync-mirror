# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dropbear/dropbear-0.52-r1.ebuild,v 1.3 2012/08/12 03:56:20 vapier Exp $

inherit eutils savedconfig pam user

DESCRIPTION="small SSH 2 client/server designed for small memory environments"
HOMEPAGE="http://matt.ucc.asn.au/dropbear/dropbear.html"
SRC_URI="http://matt.ucc.asn.au/dropbear/releases/${P}.tar.bz2
	http://matt.ucc.asn.au/dropbear/testing/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="bsdpty minimal multicall pam static syslog zlib"

DEPEND="zlib? ( sys-libs/zlib )
	pam? ( virtual/pam )"
RDEPEND="${DEPEND}
	pam? ( >=sys-auth/pambase-20080219.1 )"

set_options() {
	use minimal \
		&& progs="dropbear dbclient dropbearkey" \
		|| progs="dropbear dbclient dropbearkey dropbearconvert scp"
	use multicall && makeopts="${makeopts} MULTI=1"
	use static && makeopts="${makeopts} STATIC=1"
}

pkg_setup() {
	if use pam && use static ; then
		die "USE='pam static' makes no sense ... pick one"
	fi

	enewgroup sshd 22
	enewuser sshd 22 -1 /var/empty sshd
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/dropbear-0.46-dbscp.patch
	sed -i \
		-e '/SFTPSERVER_PATH/s:".*":"/usr/lib/misc/sftp-server":' \
		-e '/XAUTH_COMMAND/s:/X11R6/:/:' \
		options.h
	sed -i \
		-e '/pam_start/s:sshd:dropbear:' \
		svr-authpam.c || die
	restore_config options.h
}

src_compile() {
	if use static && use pam ; then
		ewarn "You cannot have USE='static pam'.  Assuming static is more important."
	fi
	econf \
		$(use_enable zlib) \
		$(use_enable pam) \
		$(use_enable !bsdpty openpty) \
		$(use_enable syslog) \
		|| die
	set_options
	emake ${makeopts} PROGRAMS="${progs}" || die "make ${makeopts} failed"
}

src_install() {
	set_options
	emake install DESTDIR="${D}" ${makeopts} PROGRAMS="${progs}" || die "make install failed"
	doman *.8
	newinitd "${FILESDIR}"/dropbear.init.d dropbear || die
	newconfd "${FILESDIR}"/dropbear.conf.d dropbear || die
	dodoc CHANGES README TODO SMALL MULTI

	# The multi install target does not install the links
	if use multicall ; then
		cd "${D}"/usr/bin
		local x
		for x in ${progs} ; do
			ln -s dropbearmulti ${x} || die "ln -s dropbearmulti to ${x} failed"
		done
		rm -f dropbear
		dodir /usr/sbin
		dosym ../bin/dropbearmulti /usr/sbin/dropbear
		cd "${S}"
	fi
	save_config options.h

	if ! use minimal ; then
		mv "${D}"/usr/bin/{,db}scp || die
	fi

	pamd_mimic system-remote-login dropbear auth account password session \
		|| die "unable to mimic system-remote-login pamd file."
}
