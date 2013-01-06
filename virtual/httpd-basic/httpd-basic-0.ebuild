# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/httpd-basic/httpd-basic-0.ebuild,v 1.7 2012/03/24 12:27:18 pacho Exp $

DESCRIPTION="Virtual for static HTML-enabled webservers"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="|| (
	www-servers/apache
	www-servers/lighttpd
	www-servers/boa
	www-servers/bozohttpd
	www-servers/cherokee
	www-servers/fnord
	www-servers/gorg
	www-servers/mongrel
	www-servers/monkeyd
	www-servers/nginx
	www-servers/publicfile
	www-servers/resin
	www-servers/skunkweb
	www-servers/thttpd
	www-servers/tomcat
	www-servers/webfs
	)"
DEPEND=""
