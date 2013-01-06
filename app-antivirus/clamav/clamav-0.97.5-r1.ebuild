# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/clamav/clamav-0.97.5-r1.ebuild,v 1.9 2012/10/05 15:49:20 ranger Exp $

EAPI=4

inherit eutils flag-o-matic user

DESCRIPTION="Clam Anti-Virus Scanner"
HOMEPAGE="http://www.clamav.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE="bzip2 clamdtop iconv ipv6 milter selinux static-libs"

CDEPEND="bzip2? ( app-arch/bzip2 )
	clamdtop? ( sys-libs/ncurses )
	iconv? ( virtual/libiconv )
	milter? ( || ( mail-filter/libmilter mail-mta/sendmail ) )
	dev-libs/libtommath
	>=sys-libs/zlib-1.2.2
	sys-devel/libtool"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-clamav )"

RESTRICT="test"

DOCS=( AUTHORS BUGS ChangeLog FAQ INSTALL NEWS README UPGRADE )

PATCHES=(
	"${FILESDIR}"/${PN}-0.97-nls.patch
)

pkg_setup() {
	enewgroup clamav
	enewuser clamav -1 -1 /dev/null clamav
}

src_prepare() {
	use ppc64 && append-flags -mminimal-toc
}

src_configure() {
	econf \
		--disable-experimental \
		--enable-id-check \
		--with-dbdir="${EPREFIX}"/var/lib/clamav \
		--with-system-tommath \
		--with-zlib="${EPREFIX}"/usr \
		$(use_enable bzip2) \
		$(use_enable clamdtop) \
		$(use_enable ipv6) \
		$(use_enable milter) \
		$(use_enable static-libs static) \
		$(use_with iconv)
}

src_install() {
	default

	rm -rf "${ED}"/var/lib/clamav
	newinitd "${FILESDIR}"/clamd.initd clamd
	newconfd "${FILESDIR}"/clamd.conf clamd

	keepdir /var/lib/clamav
	fowners clamav:clamav /var/lib/clamav
	keepdir /var/run/clamav
	fowners clamav:clamav /var/run/clamav
	keepdir /var/log/clamav
	fowners clamav:clamav /var/log/clamav

	dodir /etc/logrotate.d
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/clamav.logrotate clamav

	# Modify /etc/{clamd,freshclam}.conf to be usable out of the box
	sed -i -e "s:^\(Example\):\# \1:" \
		-e "s:.*\(PidFile\) .*:\1 ${EPREFIX}/var/run/clamav/clamd.pid:" \
		-e "s:.*\(LocalSocket\) .*:\1 ${EPREFIX}/var/run/clamav/clamd.sock:" \
		-e "s:.*\(User\) .*:\1 clamav:" \
		-e "s:^\#\(LogFile\) .*:\1 ${EPREFIX}/var/log/clamav/clamd.log:" \
		-e "s:^\#\(LogTime\).*:\1 yes:" \
		-e "s:^\#\(AllowSupplementaryGroups\).*:\1 yes:" \
		"${ED}"/etc/clamd.conf
	sed -i -e "s:^\(Example\):\# \1:" \
		-e "s:.*\(PidFile\) .*:\1 ${EPREFIX}/var/run/clamav/freshclam.pid:" \
		-e "s:.*\(DatabaseOwner\) .*:\1 clamav:" \
		-e "s:^\#\(UpdateLogFile\) .*:\1 ${EPREFIX}/var/log/clamav/freshclam.log:" \
		-e "s:^\#\(NotifyClamd\).*:\1 ${EPREFIX}/etc/clamd.conf:" \
		-e "s:^\#\(ScriptedUpdates\).*:\1 yes:" \
		-e "s:^\#\(AllowSupplementaryGroups\).*:\1 yes:" \
		"${ED}"/etc/freshclam.conf

	if use milter ; then
		# MilterSocket one to include ' /' because there is a 2nd line for
		# inet: which we want to leave
		dodoc "${FILESDIR}"/clamav-milter.README.gentoo
		sed -i -e "s:^\(Example\):\# \1:" \
			-e "s:.*\(PidFile\) .*:\1 ${EPREFIX}/var/run/clamav/clamav-milter.pid:" \
			-e "s+^\#\(ClamdSocket\) .*+\1 unix:${EPREFIX}/var/run/clamav/clamd.sock+" \
			-e "s:.*\(User\) .*:\1 clamav:" \
			-e "s+^\#\(MilterSocket\) /.*+\1 unix:${EPREFIX}/var/run/clamav/clamav-milter.sock+" \
			-e "s:^\#\(AllowSupplementaryGroups\).*:\1 yes:" \
			-e "s:^\#\(LogFile\) .*:\1 ${EPREFIX}/var/log/clamav/clamav-milter.log:" \
			"${ED}"/etc/clamav-milter.conf
		cat > "${ED}"/etc/conf.d/clamd <<-EOF
			MILTER_NICELEVEL=19
			START_MILTER=no
		EOF
	fi

	prune_libtool_files
}

pkg_postinst() {
	if use milter ; then
		elog "For simple instructions how to setup the clamav-milter read the"
		elog "clamav-milter.README.gentoo in /usr/share/doc/${PF}"
	fi
}
