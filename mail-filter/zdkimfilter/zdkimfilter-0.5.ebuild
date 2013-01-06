# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/zdkimfilter/zdkimfilter-0.5.ebuild,v 1.2 2011/02/27 00:32:53 dragonheart Exp $

EAPI=2
DESCRIPTION="DKIM filter for Courier-MTA"
HOMEPAGE="http://www.tana.it/sw/zdkimfilter"
SRC_URI="http://www.tana.it/sw/zdkimfilter/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug mysql opendbx"

DEPEND=">=mail-filter/opendkim-2.2.0
		mail-mta/courier
		opendbx? ( >=dev-db/opendbx-1.4.0 )
		mysql? ( >=virtual/mysql-5.0 )"
RDEPEND="${DEPEND}"

src_configure() {
	local myconf
	use mysql && myconf="--with-backends='mysql'"

	econf $(use_enable debug) \
	    $(use_enable opendbx utils) \
		${myconf} \
		|| die "failed to configure"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm "${D}"/etc/courier/filters/zdkimfilter.conf
	diropts -o mail -g mail
	dodir /etc/courier/filters/keys
}
