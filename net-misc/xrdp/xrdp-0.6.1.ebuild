# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/xrdp/xrdp-0.6.1.ebuild,v 1.4 2014/10/27 14:33:09 mgorny Exp $

EAPI=5

inherit autotools eutils pam systemd

MY_P="${PN}-v${PV}"

DESCRIPTION="An open source Remote Desktop Protocol server"
HOMEPAGE="http://www.xrdp.org/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kerberos pam"

RDEPEND="dev-libs/openssl:0=
	x11-libs/libX11:0=
	x11-libs/libXfixes:0=
	kerberos? ( virtual/krb5:0= )
	pam? ( virtual/pam:0= )"
DEPEND="${RDEPEND}"
RDEPEND="${RDEPEND}
	|| (
		net-misc/tigervnc:0=[server,xorgmodule]
		net-misc/x11rdp:0=
	)"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch_user

	# disallow root login by default
	sed -i -e '/^AllowRootLogin/s/1/0/' sesman/sesman.ini || die

	eautoreconf
	# part of ./bootstrap
	ln -s ../config.c sesman/tools/config.c || die
}

src_configure() {
	use kerberos && use pam \
		&& ewarn "Both kerberos & pam auth enabled, kerberos will take precedence."

	local myconf=(
		# warning: configure.ac is completed flawed

		--localstatedir="${EPREFIX}"/var

		# -- authentication backends --
		# kerberos is inside !SESMAN_NOPAM conditional for no reason
		$(use pam || use kerberos || echo --enable-nopam)
		$(usex kerberos --enable-kerberos '')
		# pam_userpass is not in Gentoo at the moment
		#--disable-pamuserpass

		# -- others --
		$(usex debug --enable-xrdpdebug '')

		# --enable-freerdp1 does not work with 1.1 in gentoo
	)

	econf "${myconf[@]}"
}

src_install() {
	default
	prune_libtool_files --all

	# use our pam.d file
	use pam && newpamd "${FILESDIR}"/xrdp-sesman.pamd xrdp-sesman
	# and our startwm.sh
	exeinto /etc/xrdp
	doexe "${FILESDIR}"/startwm.sh

	# package empty /etc/xrdp/rsakeys.ini rather than bundled keys :)
	: > rsakeys.ini
	insinto /etc/xrdp
	doins rsakeys.ini

	# contributed by Jan Psota <jasiupsota@gmail.com>
	newinitd "${FILESDIR}/${PN}-initd" ${PN}
}

pkg_preinst() {
	# either copy existing keys over to avoid CONFIG_PROTECT whining
	# or generate new keys (but don't include them in binpkg!)
	if [[ -f ${EROOT}/etc/xrdp/rsakeys.ini ]]; then
		cp {"${EROOT}","${ED}"}/etc/xrdp/rsakeys.ini || die
	else
		einfo "Running xrdp-keygen to generate new rsakeys.ini ..."
		"${S}"/keygen/xrdp-keygen xrdp "${ED}"/etc/xrdp/rsakeys.ini \
			|| die "xrdp-keygen failed to generate RSA keys"
	fi
}

pkg_postinst() {
	# check for use of bundled rsakeys.ini (installed by default upstream)
	if [[ $(cksum "${EROOT}"/etc/xrdp/rsakeys.ini) == '2935297193 1019 '* ]]
	then
		ewarn "You seem to be using upstream bundled rsakeys.ini. This means that"
		ewarn "your communications are encrypted using a well-known key. Please"
		ewarn "consider regenerating rsakeys.ini using the following command:"
		ewarn
		ewarn "  ${EROOT}/usr/bin/xrdp-keygen xrdp ${EROOT}/etc/xrdp/rsakeys.ini"
		ewarn
	fi

	elog "Various session types require different backend implementations:"
	elog "- sesman-Xvnc requires net-misc/tigervnc[server,xorgmodule]"
	elog "- sesman-X11rdp requires net-misc/x11rdp"
}
