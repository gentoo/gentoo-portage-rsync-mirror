# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/umurmur/umurmur-0.2.13.ebuild,v 1.5 2013/11/22 15:11:55 hasufell Exp $

EAPI=5

inherit eutils readme.gentoo user

DESCRIPTION="Minimalistic Murmur (Mumble server)"
HOMEPAGE="http://code.google.com/p/umurmur/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-libs/protobuf-c-0.14
	dev-libs/libconfig
	dev-libs/openssl:0"

RDEPEND="${DEPEND}"

DOC_CONTENTS="
	A configuration file has been installed at /etc/umurmur.conf - you may
	want to review it. See also\n
	http://code.google.com/p/umurmur/wiki/Configuring02x
"

pkg_setup() {
	enewgroup murmur
	enewuser murmur "" "" "" murmur
}

src_configure() {
	econf --with-ssl=openssl
}

src_install() {
	emake DESTDIR="${D}" install

	newinitd "${FILESDIR}"/umurmurd.initd umurmurd
	newconfd "${FILESDIR}"/umurmurd.confd umurmurd

	dodoc AUTHORS ChangeLog
	newdoc README.md README

	# Some permissions are adjusted as the config may contain a server
	# password, and /etc/umurmur will typically contain the cert and the
	# key used to sign it, which are read after priveleges are dropped.
	local confdir="/etc/umurmur"
	dodir ${confdir}
	fperms 0750 ${confdir}
	fowners root:murmur ${confdir}

	insinto ${confdir}
	doins "${FILESDIR}"/umurmur.conf
	fperms 0640 ${confdir}/umurmur.conf

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
