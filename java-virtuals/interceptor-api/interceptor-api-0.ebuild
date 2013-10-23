# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/interceptor-api/interceptor-api-0.ebuild,v 1.1 2013/10/23 18:04:48 tomwij Exp $

EAPI="5"

inherit java-virtuals-2

DESCRIPTION="Virtual for Interceptor API (javax.interceptor)"
HOMEPAGE="http://www.gentoo.org"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="dev-java/glassfish-interceptor-api:0"

JAVA_VIRTUAL_PROVIDES="glassfish-interceptor-api"
