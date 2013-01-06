# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/smrsh/smrsh-8.12.10.ebuild,v 1.8 2009/12/03 11:41:55 maekke Exp $

DESCRIPTION="Sendmail restricted shell, for use with MTAs other than Sendmail"
HOMEPAGE="http://www.sendmail.org/"
SRC_URI="ftp://ftp.sendmail.org/pub/sendmail/sendmail.${PV}.tar.gz"

LICENSE="Sendmail"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="sys-devel/m4
	>=sys-apps/sed-4"
RDEPEND="${DEPEND}
	!mail-mta/sendmail"

S="${WORKDIR}/sendmail-${PV}"

src_compile() {
	cd "${S}/${PN}"

	sed -e "s:/usr/libexec:/usr/sbin:g" \
		-e "s:/usr/adm/sm.bin:/var/lib/smrsh:g" \
		-i README -i smrsh.8 || die "sed failed"

	sed -e "s:@@confCCOPTS@@:${CFLAGS}:" "${FILESDIR}/site.config.m4" \
		> "${S}/devtools/Site/site.config.m4" || die "sed failed"

	/bin/sh Build
}

src_install() {
	cd "${S}/${PN}"
	dosbin "${S}/obj.$(uname -s).$(uname -r).$(arch)/${PN}/${PN}"

	doman smrsh.8
	dodoc README

	keepdir /var/lib/smrsh
}

pkg_postinst() {
	elog "smrsh is compiled to look for programs in /var/lib/smrsh."
	echo
}
