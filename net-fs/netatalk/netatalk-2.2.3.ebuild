# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/netatalk/netatalk-2.2.3.ebuild,v 1.5 2013/08/22 16:01:55 jlec Exp $

EAPI="4"

inherit pam eutils flag-o-matic multilib autotools

DESCRIPTION="Open Source AFP server and other AppleTalk-related utilities"
HOMEPAGE="http://netatalk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="acl appletalk avahi cracklib cups debug kerberos ldap pam quota slp ssl static-libs tcpd"

RDEPEND="
	!app-editors/yudit
	dev-libs/libgcrypt
	sys-apps/coreutils
	>=sys-libs/db-4.2.52
	acl? (
		sys-apps/attr
		sys-apps/acl
	)
	appletalk? ( cups? ( net-print/cups ) )
	avahi? ( net-dns/avahi[dbus] )
	cracklib? ( sys-libs/cracklib )
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	pam? ( virtual/pam )
	slp? ( net-libs/openslp )
	ssl? ( dev-libs/openssl )
	tcpd? ( sys-apps/tcp-wrappers )
	"
DEPEND="${RDEPEND}"

RESTRICT="test"

REQUIRED_USE="ldap? ( acl )"

DOCS=( CONTRIBUTORS NEWS VERSION AUTHORS doc/README.AppleTalk )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.2.2-gentoo.patch
	eautoreconf
}

src_configure() {
	local myconf=

	if use appletalk; then
		myconf+=" --enable-ddp --enable-timelord $(use_enable cups)"
	else
		myconf+=" --disable-ddp --disable-timelord --disable-cups"
	fi

	if use acl; then
		myconf+=" --with-acls $(use_with ldap)"
	else
		myconf+=" --without-acls --without-ldap"
	fi

	append-flags -fno-strict-aliasing

	# Ignore --enable-gentoo, we install the init.d by hand and we avoid having
	# to sed the Makefiles to not do rc-update.
	econf \
		$(use_enable avahi zeroconf) \
		$(use_enable debug) \
		$(use_enable kerberos krbV-uam) \
		$(use_enable quota) \
		$(use_enable slp srvloc) \
		$(use_enable static-libs static) \
		$(use_enable tcpd tcp-wrappers) \
		$(use_with cracklib) \
		$(use_with pam) \
		$(use_with ssl ssl-dir) \
		--disable-krb4-uam \
		--disable-afs \
		--enable-fhs \
		--with-bdb=/usr \
		${myconf}
}

src_install() {
	default

	newinitd "${FILESDIR}"/afpd.init.3 afpd
	newinitd "${FILESDIR}"/cnid_metad.init.2 cnid_metad

	if use appletalk; then
		newinitd "${FILESDIR}"/atalkd.init atalkd
		newinitd "${FILESDIR}"/atalk_service.init.2 timelord
		newinitd "${FILESDIR}"/atalk_service.init.2 papd
	fi

	use avahi || sed -i -e '/need avahi-daemon/d' "${D}"/etc/init.d/afpd
	use slp || sed -i -e '/need slpd/d' "${D}"/etc/init.d/afpd

	use ldap || rm "${D}"/etc/netatalk/afp_ldap.conf

	rm "${D}"/etc/netatalk/netatalk.conf

	# The pamd file isn't what we need, use pamd_mimic_system
	rm -rf "${D}/etc/pam.d"
	pamd_mimic_system netatalk auth account password session

	# Move /usr/include/netatalk to /usr/include/netatalk2 to avoid collisions
	# with /usr/include/netatalk/at.h provided by glibc (strange, uh?)
	# Packages that wants to link to netatalk should then probably change the
	# includepath then, but right now, nothing uses netatalk.
	# On a side note, it also solves collisions with freebsd-lib and other libcs
	mv "${D}"/usr/include/netatalk{,2} || die
	sed -i \
		-e 's/include <netatalk/include <netatalk2/g' \
		"${D}"usr/include/{netatalk2,atalk}/* || die

	# These are not used at all, as the uams are loaded with their .so
	# extension.
	rm "${D}"/usr/$(get_libdir)/netatalk/*.la

	use static-libs || rm "${D}"/usr/$(get_libdir)/*.la
}

pkg_postinst() {
	elog "Starting from version 2.2.1-r1 the netatalk init script has been split"
	elog "into different services depending on what you need to start."
	elog "This was done to make sure that all services are started and reported"
	elog "properly."
	elog ""
	elog "The new services are:"
	elog "  cnid_metad"
	elog "  afpd"
	if use appletalk; then
		elog "  atalkd"
		elog "  timelord"
		elog "  papd"
	fi
	elog ""
	elog "Dependencies should be resolved automatically depending on settings"
	elog "but please report issues with this on https://bugs.gentoo.org/ if"
	elog "you find any."
	elog ""
	elog "The old configuration file /etc/netatalk/netatalk.conf is no longer"
	elog "installed, and will be ignored. The new configuration is supposed"
	elog "to be done through individual /etc/conf.d files, for everything that"
	elog "cannot be set already through their respective configuration files."
}
