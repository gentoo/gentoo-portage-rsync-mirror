# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-pam-modules/freebsd-pam-modules-10.1.ebuild,v 1.1 2015/03/08 14:01:57 mgorny Exp $

EAPI=3

inherit bsdmk freebsd multilib pam

DESCRIPTION="FreeBSD's PAM authentication modules"
SLOT="0"

IUSE="kerberos nis"

if [[ ${PV} != *9999* ]]; then
	KEYWORDS="~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
	SRC_URI="http://dev.gentoo.org/~mgorny/dist/freebsd/${RV}/${LIB}.tar.xz"
fi

RDEPEND=">=sys-auth/openpam-20050201-r1
	kerberos? ( dev-libs/openssl
		virtual/krb5 )"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	=sys-freebsd/freebsd-sources-${RV}*"

S=${WORKDIR}/lib/libpam/modules

PATCHES=( "${FILESDIR}"/${PN}-9.0-gentoo.patch )

pkg_setup() {
	# Avoid installing pam_ssh as that has its own ebuild.
	mymakeopts="${mymakeopts} WITHOUT_OPENSSH= "
	use kerberos || mymakeopts="${mymakeopts} WITHOUT_KERBEROS= "
	use nis || mymakeopts="${mymakeopts} WITHOUT_NIS= "
}

src_prepare() {
	for module in pam_deny pam_passwdqc pam_permit pam_krb5; do
		sed -i -e "s:${module}::" "${S}"/modules.inc
	done
}

src_install() {
	mkinstall "LIBDIR=/$(get_libdir)/security" || die "install failed"

	dodoc "${FILESDIR}/README.pamd"
}
