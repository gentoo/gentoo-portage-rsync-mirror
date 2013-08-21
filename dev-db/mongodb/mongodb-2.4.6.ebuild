# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mongodb/mongodb-2.4.6.ebuild,v 1.1 2013/08/21 12:41:54 ultrabug Exp $

EAPI=4
SCONS_MIN_VERSION="1.2.0"

inherit eutils flag-o-matic multilib pax-utils scons-utils user versionator

MY_P=${PN}-src-r${PV/_rc/-rc}

DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
HOMEPAGE="http://www.mongodb.org"
SRC_URI="http://downloads.mongodb.org/src/${MY_P}.tar.gz
	mms-agent? ( http://dev.gentoo.org/~ultrabug/20130821-10gen-mms-agent.zip )"

LICENSE="AGPL-3 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-embedded-v8 kerberos mms-agent sharedclient spidermonkey ssl static-libs"

PDEPEND="mms-agent? ( dev-python/pymongo app-arch/unzip )"
RDEPEND="
	!spidermonkey? (
		!embedded-v8? ( <dev-lang/v8-3.19 )
	)
	>=dev-libs/boost-1.50[threads(+)]
	dev-libs/libpcre[cxx]
	dev-util/google-perftools
	net-libs/libpcap
	app-arch/snappy
	ssl? ( >=dev-libs/openssl-1.0.1c )"
DEPEND="${RDEPEND}
	sys-libs/readline
	sys-libs/ncurses
	kerberos? ( dev-libs/cyrus-sasl[kerberos] )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	enewgroup mongodb
	enewuser mongodb -1 -1 /var/lib/${PN} mongodb

	scons_opts="  --cc=$(tc-getCC) --cxx=$(tc-getCXX)"
	scons_opts+=" --use-system-tcmalloc"
	scons_opts+=" --use-system-pcre"
	scons_opts+=" --use-system-snappy"
	scons_opts+=" --use-system-boost"

	if use kerberos; then
		scons_opts+=" --use-sasl-client"
	fi

	if use sharedclient; then
		scons_opts+=" --sharedclient"
	fi

	if use spidermonkey; then
		scons_opts+=" --usesm"
	else
		if use embedded-v8; then
			scons_opts+=" --usev8"
		else
			scons_opts+=" --use-system-v8"
		fi
	fi

	if use ssl; then
		scons_opts+=" --ssl"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.4.5-fix-scons.patch"
	epatch "${FILESDIR}/${PN}-2.2-r1-fix-boost.patch"

	# bug #462606
	sed -i -e "s@\$INSTALL_DIR/lib@\$INSTALL_DIR/$(get_libdir)@g" src/SConscript.client || die
}

src_compile() {
	escons ${scons_opts} all
}

src_install() {
	escons ${scons_opts} --full --nostrip install --prefix="${ED}"/usr

	use static-libs || find "${ED}"/usr/ -type f -name "*.a" -delete

	if ! use spidermonkey; then
		pax-mark m "${ED}"/usr/bin/{mongo,mongod}
	fi

	for x in /var/{lib,log}/${PN}; do
		keepdir "${x}"
		fowners mongodb:mongodb "${x}"
	done

	doman debian/mongo*.1
	dodoc README docs/building.md

	newinitd "${FILESDIR}/${PN}.initd-r1" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
	newinitd "${FILESDIR}/${PN/db/s}.initd-r1" ${PN/db/s}
	newconfd "${FILESDIR}/${PN/db/s}.confd" ${PN/db/s}

	insinto /etc/logrotate.d/
	newins "${FILESDIR}/${PN}.logrotate" ${PN}

	if use mms-agent; then
		local MY_PN="mms-agent"
		local MY_D="/opt/${MY_PN}"
		insinto ${MY_D}
		doins "${WORKDIR}/${MY_PN}/"*
		fowners -R mongodb:mongodb ${MY_D}
		newinitd "${FILESDIR}/${MY_PN}.initd" ${MY_PN}
		newconfd "${FILESDIR}/${MY_PN}.confd" ${MY_PN}
	fi
}

pkg_preinst() {
	# wrt bug #461466
	if [[ "$(get_libdir)" == "lib64" ]]; then
		rmdir "${ED}"/usr/lib/ &>/dev/null
	fi
}

src_test() {
	escons ${scons_opts} test
	"${S}"/test --dbpath=unittest || die
}

pkg_postinst() {
	if use embedded-v8; then
		ewarn "You chose to build ${PN} using embedded v8."
		ewarn "This is not recommended by Gentoo and should be used to resolve"
		ewarn "blockers with packages requiring >=v8-3.19 only !"
		ewarn "See the following bug [1] and jira issue [2] for more info."
		ewarn "    [1] https://bugs.gentoo.org/show_bug.cgi?id=471582"
		ewarn "    [2] https://jira.mongodb.org/browse/SERVER-10282"
	fi
	if [[ ${REPLACING_VERSIONS} < 2.4 ]]; then
		ewarn "You just upgraded from a previous version of mongodb !"
		ewarn "Make sure you run 'mongod --upgrade' before using this version."
	fi
	elog "Journaling is now enabled by default, see /etc/conf.d/${PN}"
}
