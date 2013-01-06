# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/v8cgi/v8cgi-0.9.2.ebuild,v 1.1 2011/12/24 01:02:35 weaver Exp $

EAPI=4

inherit eutils toolchain-funcs flag-o-matic

MY_P=${P}-src
LIB_P="v8"

DESCRIPTION="Small set of C++ and JS libraries, allowing coder to use JS as a server-side HTTP processing language"
HOMEPAGE="http://code.google.com/p/${PN}/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug mysql postgres sqlite memcached fcgi gd xerces opengl apache"

RDEPEND="dev-lang/v8
	memcached? ( dev-libs/libmemcached )
	apache? ( www-servers/apache )
	opengl? ( virtual/opengl )
	xerces? ( >=dev-libs/xerces-c-3.0.0 )
	gd? ( media-libs/gd )
	sqlite? ( dev-db/sqlite )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql-server )"
DEPEND="${RDEPEND}
	>=dev-util/scons-0.96.93"

S="${WORKDIR}/${MY_P}"

src_compile() {
	local myconf

	filter-flags -ftracer -fomit-frame-pointer
	if [[ $(gcc-major-version) -eq 3 ]] ; then
		filter-flags -fstack-protector
		append-flags -fno-stack-protector
	fi

	myconf="${myconf} v8_path=/usr/lib/"
	myconf="${myconf} os=posix"

	if use debug ; then
		myconf="${myconf} debug=1"
	fi
	if use !mysql ; then
		myconf="${myconf} mysql=0"
	fi
	if use postgres ; then
		myconf="${myconf} pgsql=1"
	fi
	if use !sqlite ; then
		myconf="${myconf} sqlite=0"
	fi
	if use fcgi ; then
		myconf="${myconf} fcgi=1"
	fi
	if use !gd ; then
		myconf="${myconf} gd=0"
	fi
	if use !memcached ; then
		myconf="${myconf} memcached=0"
	fi
	if use xerces ; then
		myconf="${myconf} xdom=1"
	fi
	if use opengl ; then
		myconf="${myconf} gl=1"
	fi
	if use !apache ; then
		myconf="${myconf} module=0"
	fi

	cd ${PN}
	scons $myconf \
		${MAKEOPTS/-l[0-9]} \
		--implicit-deps-unchanged \
		prefix=/usr \
		docdir=/usr/share/doc/${PF} \
		default_targets=none || die "scons failed"
}

src_install() {
	cd ${PN}

	insinto /usr/lib/${PN}
	doins lib/*

	insinto /usr/share/${PN}/example
	doins example/*

	insinto /etc
	newins v8cgi.conf.posix v8cgi.conf

	dobin v8cgi
}
