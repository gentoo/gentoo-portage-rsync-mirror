# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailbase/mailbase-0.00-r6.ebuild,v 1.21 2011/02/06 10:09:31 leio Exp $

DESCRIPTION="MTA layout package"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_install() {
	dodir /etc/mail
	insinto /etc/mail
	doins ${FILESDIR}/aliases
	insinto /etc/
	doins ${FILESDIR}/mailcap

	keepdir /var/spool/mail
	fowners root:mail /var/spool/mail
	fperms 0775 /var/spool/mail
	dosym /var/spool/mail /var/mail
}

pkg_postinst() {
	if [ ! -d ${ROOT}/var/spool/mail ]
	then
		mkdir -p ${ROOT}/var/spool/mail
	fi

	# Always set these to close bug #8029.
	chown root:mail ${ROOT}/var/spool/mail
	chmod 0775 ${ROOT}/var/spool/mail
}
