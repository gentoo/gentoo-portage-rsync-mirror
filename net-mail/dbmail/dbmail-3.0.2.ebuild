# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/dbmail/dbmail-3.0.2.ebuild,v 1.3 2012/12/04 11:10:35 ago Exp $

EAPI="4"
inherit eutils multilib python versionator

DESCRIPTION="DBMail is an open-source project that enables storage of mail messages in a relational database."
HOMEPAGE="http://www.dbmail.org/"
SRC_URI="http://www.dbmail.org/download/$(get_version_component_range 1-2)/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="ldap sieve +sqlite ssl static python"

DEPEND="dev-db/libzdb
	sieve? ( >=mail-filter/libsieve-2.2.1 )
	ldap? ( >=net-nds/openldap-2.3.33 )
	python? ( net-zope/zope-interface )
	app-text/asciidoc
	app-text/xmlto
	app-crypt/mhash
	sys-libs/zlib
	>=dev-libs/gmime-2.4.6:2.4
	>=dev-libs/glib-2.16
	dev-libs/libevent
	ssl? ( dev-libs/openssl )"
#asciidoc and xmlto needed?
RDEPEND="${DEPEND}"

pkg_setup() {
	python_pkg_setup
	enewgroup dbmail
	enewuser dbmail -1 -1 /var/lib/dbmail dbmail
}

src_configure() {
	local myconf=""
	use ldap && myconf=${myconf}" --with-auth-ldap"

	econf \
		--sysconfdir=/etc/dbmail \
		$(use_enable static) \
		$(use_with sieve) \
		${myconf}
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS BUGS ChangeLog README* INSTALL NEWS THANKS UPGRADING

#	docinto sql/mysql
#	dodoc sql/mysql/*
#	docinto sql/postgresql
#	dodoc sql/postgresql/*
#	docinto sql/sqlite
#	dodoc sql/sqlite/*
#	docinto test-scripts
#	dodoc test-scripts/*
#	docinto contrib/sql2sql
#	dodoc contrib/sql2sql/*
#	docinto contrib/mailbox2dbmail
#	dodoc contrib/mailbox2dbmail/README
#	docinto contrib
#	dodoc contrib/dbmailclient.php
	dodoc -r sql
	dodoc -r test-scripts
	dodoc -r contrib
	## TODO: install other contrib stuff

	sed -i -e "s:nobody:dbmail:" dbmail.conf
	sed -i -e "s:nogroup:dbmail:" dbmail.conf
	sed -i -e "s:/var/run:/var/run/dbmail:" dbmail.conf
	#sed -i -e "s:#library_directory:library_directory:" dbmail.conf

	insinto /etc/dbmail
	newins dbmail.conf dbmail.conf.dist

	# change config path to our default and use the conf.d and init.d files from the contrib dir
	sed -i -e "s:/etc/dbmail.conf:/etc/dbmail/dbmail.conf:" contrib/startup-scripts/gentoo/init.d-dbmail
	sed -i -e "s:exit 0:return 1:" contrib/startup-scripts/gentoo/init.d-dbmail
	sed -i -e "s:/var/run:/var/run/dbmail:" contrib/startup-scripts/gentoo/init.d-dbmail
	newconfd contrib/startup-scripts/gentoo/conf.d-dbmail dbmail
	newinitd contrib/startup-scripts/gentoo/init.d-dbmail dbmail

	dobin contrib/mailbox2dbmail/mailbox2dbmail
	doman contrib/mailbox2dbmail/mailbox2dbmail.1
	#doman man/*.{1,5,8}

	# ldap schema
	if use ldap; then
	   insinto /etc/openldap/schema
	   doins "${S}/dbmail.schema"
	fi

	if use python; then
	   insinto $(python_get_sitedir)/dbmail
	   doins python/*.py
	   insinto $(python_get_sitedir)/dbmail/app
	   doins python/app/*.py
	   insinto $(python_get_sitedir)/dbmail/bin
	   doins python/bin/*.py
	   insinto $(python_get_sitedir)/dbmail/lib
	   doins python/lib/*.py
	   insinto $(python_get_sitedir)/dbmail/tests
	   doins python/tests/*.py
	fi

	keepdir /var/lib/dbmail
	fperms 750 /var/lib/dbmail
	fowners dbmail:dbmail /var/lib/dbmail
	keepdir /var/run/dbmail
	fowners dbmail:dbmail /var/run/dbmail
}

pkg_postinst() {
	if use python; then
	   python_mod_optimize dbmail
	fi
	elog "Please read the INSTALL file in /usr/share/doc/${PF}/"
	elog "for remaining instructions on setting up dbmail users and "
	elog "for finishing configuration to connect to your MTA and "
	elog "to connect to your db."
	echo
	elog "DBMail requires either SQLite, PostgreSQL or MySQL."
	elog "Database schemes can be found in /usr/share/doc/${PF}/"
	elog "You will also want to follow the installation instructions"
	elog "on setting up the maintenance program to delete old messages."
	elog "Don't forget to edit /etc/dbmail/dbmail.conf as well."
	echo
	elog "For regular maintenance, add this to crontab:"
	elog "0 3 * * * /usr/bin/dbmail-util -cpdy >/dev/null 2>&1"
	echo
	elog "Please make sure to run etc-update."
	elog "If you get an error message about plugins not found"
	elog "please add the library_directory configuration switch to"
	elog "dbmail.conf and set it to the correct path"
	elog "(usually /usr/lib/dbmail or /usr/lib64/dbmail on amd64)"
	elog "A sample can be found in dbmail.conf.dist after etc-update."
	echo
	elog "We are now using the init script from upstream."
	elog "Please edit /etc/conf.d/dbmail to set which services to start"
	elog "and delete /etc/init.d/dbmail-* when you are done. (don't"
	elog "forget to rc-update del dbmail-* first)"
	echo
	elog "Changed pid directory to /var/run/dbmail (see"
	elog "http://www.dbmail.org/mantis/view.php?id=949 for details)"
	echo
}

pkg_postrm() {
	     python_mod_cleanup dbmail
}
