# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/sendEmail/sendEmail-1.56.ebuild,v 1.3 2011/11/28 11:32:36 phajdan.jr Exp $

DESCRIPTION="Command line based, SMTP email agent"
HOMEPAGE="http://caspian.dotconf.net/menu/Software/SendEmail/"
SRC_URI="http://caspian.dotconf.net/menu/Software/SendEmail/${PN}-v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="ssl"

DEPEND=""
RDEPEND="dev-lang/perl
	ssl? ( dev-perl/IO-Socket-SSL )"

S="${WORKDIR}/${PN}-v${PV}"

src_install() {
	dobin sendEmail || die "failed to install sendEmail script"
	dodoc CHANGELOG  README  TODO
}
