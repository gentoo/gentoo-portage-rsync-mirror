# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/netatalk/netatalk-3.0.ebuild,v 1.4 2012/10/07 13:18:02 ulm Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils flag-o-matic multilib pam

DESCRIPTION="Open Source AFP server"
HOMEPAGE="http://netatalk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="acl avahi cracklib debug pgp kerberos ldap pam quota samba +shadow ssl static-libs tcpd"

RDEPEND="
	!app-editors/yudit
	dev-libs/libevent
	dev-libs/libgcrypt
	sys-apps/coreutils
	>=sys-libs/db-4.2.52
	acl? (
		sys-apps/attr
		sys-apps/acl
	)
	avahi? ( net-dns/avahi[dbus] )
	cracklib? ( sys-libs/cracklib )
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	pam? ( virtual/pam )
	ssl? ( dev-libs/openssl )
	tcpd? ( sys-apps/tcp-wrappers )
	"
DEPEND="${RDEPEND}"
PDEPEND="sys-apps/openrc"

RESTRICT="test"

REQUIRED_USE="ldap? ( acl )"

DOCS=( CONTRIBUTORS NEWS VERSION AUTHORS doc/DEVELOPER )

PATCHES=( "${FILESDIR}"/${PN}-3.0-gentoo.patch )

src_configure() {
	local myeconfargs=()

	append-flags -fno-strict-aliasing

	if use acl; then
		myconf+=( --with-acls $(use_with ldap) )
	else
		myconf+=( --without-acls --without-ldap )
	fi

	# Ignore --with-init-style=gentoo, we install the init.d by hand and we avoid having
	# to sed the Makefiles to not do rc-update.
	# TODO:
	# systemd : --with-init-style=systemd
	myeconfargs+=(
		--disable-silent-rules
		$(use_enable avahi zeroconf)
		$(use_enable debug)
		$(use_enable debug debugging)
		$(use_enable pgp pgp-uam)
		$(use_enable kerberos)
		$(use_enable kerberos krbV-uam)
		$(use_enable quota)
		$(use_enable tcpd tcp-wrappers)
		$(use_with cracklib)
		$(use_with pam)
		$(use_with samba smbsharemodes)
		$(use_with shadow)
		$(use_with ssl ssl-dir)
		--enable-overwrite
		--disable-krb4-uam
		--disable-afs
		--disable-bundled-libevent
		--with-bdb=/usr
		--with-uams-path=/usr/$(get_libdir)/${PN}
		--disable-silent-rules
		)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	newinitd "${FILESDIR}"/${PN}.init ${PN}

	use avahi || sed -i -e '/need avahi-daemon/d' "${D}"/etc/init.d/${PN}

	# The pamd file isn't what we need, use pamd_mimic_system
	rm -rf "${D}/etc/pam.d"
	pamd_mimic_system netatalk auth account password session
}

pkg_postinst() {
	local fle
	if [[ ${REPLACING_VERSIONS} < 3 ]]; then
		for fle in afp_signature.conf afp_voluuid.conf; do
			if [[ -f "${ROOT}"etc/netatalk/${fle} ]]; then
				if [[ ! -f "${ROOT}"var/lib/netatalk/${fle} ]]; then
					mv \
						"${ROOT}"etc/netatalk/${fle} \
						"${ROOT}"var/lib/netatalk/
				fi
			fi
		done

		echo ""
		elog "Starting from version 3.0 only uses a single init script again"
		elog "Please update your runlevels accordingly"
		echo ""
		elog "Dependencies should be resolved automatically depending on settings"
		elog "but please report issues with this on https://bugs.gentoo.org/ if"
		elog "you find any."
		echo ""
		elog "Following config files are obsolete now:"
		elog "afpd.conf, netatalk.conf, AppleVolumes.default and afp_ldap.conf"
		elog "in favour of"
		elog "/etc/afp.conf"
		echo ""
		elog "Please convert your existing configs before you restart your daemon"
		echo ""
		elog "The new AppleDouble default backend is appledouble = ea"
		elog "Existing entries will be updated on access, but can do an offline"
		elog "conversion with"
		elog "dbd -ruve /path/to/Volume"
		echo ""
		elog "For general notes on the upgrade, please visit"
		elog "http://netatalk.sourceforge.net/3.0/htmldocs/upgrade.html"
		echo ""
	fi
}
