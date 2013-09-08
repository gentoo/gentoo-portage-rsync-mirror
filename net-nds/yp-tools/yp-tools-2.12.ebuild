# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/yp-tools/yp-tools-2.12.ebuild,v 1.2 2013/09/08 13:55:50 maekke Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Network Information Service tools"
HOMEPAGE="http://www.linux-nis.org/nis/"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/net/NIS/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls"

src_configure() {
	local myconf="--sysconfdir=/etc/yp"
	if ! use nls
	then
		myconf="${myconf} --disable-nls"
		mkdir intl
		touch intl/libintl.h
		export CPPFLAGS="${CPPFLAGS} -I${S}"

		for i in lib/nicknames.c src/*.c
		do
			cp ${i} ${i}.orig
			sed 's:<libintl.h>:<intl/libintl.h>:' \
				${i}.orig > ${i}
		done
	fi
	econf ${myconf} || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	insinto /etc/yp ; doins etc/nicknames
	# This messes up boot so we remove it
	rm -f \
		"${D}/bin/ypdomainname" \
		"${D}/bin/nisdomainname" \
		"${D}/bin/domainname"
}
