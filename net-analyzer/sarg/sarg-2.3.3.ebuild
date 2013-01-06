# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sarg/sarg-2.3.3.ebuild,v 1.1 2012/12/18 21:39:26 jer Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="Squid Analysis Report Generator"
HOMEPAGE="http://sarg.sourceforge.net/sarg.php"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="+gd pcre"

DEPEND="
	pcre? ( dev-libs/libpcre )
	gd? ( media-libs/gd[png,truetype] )
"
RDEPEND="${DEPEND}"

DOCS=( BETA-TESTERS CONTRIBUTORS DONATIONS README ChangeLog htaccess )

src_prepare() {
	sed -i configure.in -e '/LDFLAGS=/s:LDFLAGS:LIBS:g' || die

	sed \
		-e 's:/usr/local/squid/var/logs/access.log:/var/log/squid/access.log:' \
		-e 's:/usr/local/\(squidGuard/squidGuard.conf\):/etc/\1:' \
		-e 's:/var/www/html/squid-reports:/var/www/localhost/htdocs/squid-reports:' \
		-e 's:/usr/local/sarg/exclude_codes:/etc/sarg/exclude_codes:' \
		-i sarg.conf || die

	sed -e 's:"/var/www/html/squid-reports":"/var/www/localhost/htdocs/squid-reports":' \
			-i log.c || die #43132

	sed	-e 's:/usr/local/sarg/passwd:/etc/sarg/passwd:' \
		-i htaccess || die

	sed -e 's:/usr/local/\(sarg/sarg.conf\):/etc/\1:' \
		-e 's:/usr/local/squid/etc/passwd:/etc/squid/passwd:' \
		-i user_limit_block || die

	sed -e 's:/usr/local/squid/etc/block.txt:/etc/squid/etc/block.txt:' \
		-i sarg-php/sarg-block-it.php || die

	sed -e 's:/usr/local/\(sarg/sarg.conf\):/etc/\1:' \
		-e 's:/usr/local/\(squidGuard/squidGuard.conf\):/etc/\1:' \
			-i sarg.1 sarg-php/sarg-squidguard-block.php || die

	# https://sourceforge.net/tracker/?func=detail&aid=3415225&group_id=68910&atid=522793
	sed 's:\(@mandir@\):\1/man1:' -i Makefile.in || die #379395

	eautoreconf
}

src_configure() {
	econf \
		$(use_with pcre) \
		$(use_with gd) \
		--sysconfdir=/etc/sarg/
}
