# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/redmine/redmine-1.4.7.ebuild,v 1.1 2013/05/11 21:29:22 pva Exp $

EAPI="4"
# rails:2.3 isn't available for ruby19 on Gentoo
#USE_RUBY="ruby18 ruby19"
USE_RUBY="ruby18"
inherit eutils depend.apache ruby-ng

DESCRIPTION="Redmine is a flexible project management web application written using Ruby on Rails framework"
HOMEPAGE="http://www.redmine.org/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
# All db-related USEs are ineffective since we depend on rails
# which depends on activerecord which depends on all ruby's db bindings
#IUSE="ldap openid imagemagick postgres sqlite mysql fastcgi passenger"
IUSE="ldap openid imagemagick fastcgi passenger"

#RDEPEND="$(ruby_implementation_depend jruby '>=' -1.6.7)[ssl]"

ruby_add_rdepend "virtual/ruby-ssl
	virtual/rubygems
	>=dev-ruby/rails-2.3.15:2.3
	dev-ruby/i18n:0.4
	>=dev-ruby/coderay-1.0.6
	>=dev-ruby/tzinfo-0.3.31
	dev-ruby/rake
	ldap? ( >=dev-ruby/ruby-net-ldap-0.3.1 )
	openid? ( >=dev-ruby/ruby-openid-2.1.4 )
	imagemagick? ( >=dev-ruby/rmagick-2 )
	fastcgi? ( dev-ruby/fcgi )
	passenger? ( www-apache/passenger )
	ruby_targets_ruby18? (
		>=dev-ruby/fastercsv-1.5
	)"
#	ruby_targets_ruby18? (
#		>=dev-ruby/fastercsv-1.5
#		postgres? ( >=dev-ruby/pg-0.11 )
#		sqlite3? ( dev-ruby/sqlite3 )
#		mysql? ( >=dev-ruby/mysql-ruby-2.8.1 )
#	)
#	ruby_targets_ruby19? (
#		postgres? ( >=dev-ruby/pg-0.11 )
#		sqlite3? ( dev-ruby/sqlite3 )
#		mysql? ( dev-ruby/mysql2:0.2 )
#	)
#	ruby_targets_jruby? (
#		dev-ruby/jruby-openssl
#		>=dev-ruby/fastercsv-1.5
#		mysql? ( dev-ruby/activerecord-jdbcmysql-adapter )
#		postgres? ( dev-ruby/activerecord-jdbcpostgresql-adapter )
#		sqlite3? ( dev-ruby/activerecord-jdbcsqlite3-adapter )
#	)

#ruby_add_bdepend ">=dev-ruby/rdoc-2.4.2
#	test? (
#		!ruby_targets_ruby19? (
#			>=dev-ruby/shoulda-2.11
#		)
#		ruby_targets_ruby19? (
#			dev-ruby/test-unit
#		)
#		ruby_targets_jruby? (
#			dev-ruby/test-unit
#		)
#		>=dev-ruby/edavis10-object_daddy
#		=dev-ruby/mocha-0.12*
#	)"

REDMINE_DIR="/var/lib/${PN}"

pkg_setup() {
	enewgroup redmine
	enewuser redmine -1 -1 "${REDMINE_DIR}" redmine
}

all_ruby_prepare() {
	rm -r log files/delete.me || die

	# bug #406605
	rm .gitignore .hgignore || die

	rm Gemfile config/preinitializer.rb || die
	epatch "${FILESDIR}/${PN}-1.4.1-bundler.patch"

	echo "CONFIG_PROTECT=\"${EPREFIX}${REDMINE_DIR}/config\"" > "${T}/50${PN}"
	echo "CONFIG_PROTECT_MASK=\"${EPREFIX}${REDMINE_DIR}/config/locales ${EPREFIX}${REDMINE_DIR}/config/settings.yml\"" >> "${T}/50${PN}"
}

all_ruby_install() {
	dodoc doc/{CHANGELOG,INSTALL,README_FOR_APP,RUNNING_TESTS,UPGRADING}
	rm -fr doc || die
	dodoc README.rdoc
	rm README.rdoc || die

	keepdir /var/log/${PN}
	dosym /var/log/${PN}/ "${REDMINE_DIR}/log"

	insinto "${REDMINE_DIR}"
	doins -r .
	keepdir "${REDMINE_DIR}/files"
	keepdir "${REDMINE_DIR}/public/plugin_assets"

	fowners -R redmine:redmine \
		"${REDMINE_DIR}/config" \
		"${REDMINE_DIR}/files" \
		"${REDMINE_DIR}/public/plugin_assets" \
		"${REDMINE_DIR}/tmp" \
		/var/log/${PN}

	fowners redmine:redmine "${REDMINE_DIR}"

	# protect sensitive data, see bug #406605
	fperms -R go-rwx \
		"${REDMINE_DIR}/config" \
		"${REDMINE_DIR}/files" \
		"${REDMINE_DIR}/tmp" \
		/var/log/${PN}

	if use passenger ; then
		has_apache
		insinto "${APACHE_VHOSTS_CONFDIR}"
		doins "${FILESDIR}/10_redmine_vhost.conf"
	else
		newconfd "${FILESDIR}/${PN}.confd" ${PN}
		newinitd "${FILESDIR}/${PN}.initd" ${PN}
	fi
	doenvd "${T}/50${PN}"
}

pkg_postinst() {
	einfo
	if [ -e "${EPREFIX}${REDMINE_DIR}/config/initializers/session_store.rb" ] ; then
		elog "Execute the following command to upgrade environment:"
		elog
		elog "# emerge --config \"=${CATEGORY}/${PF}\""
		elog
		elog "For upgrade instructions take a look at:"
		elog "http://www.redmine.org/wiki/redmine/RedmineUpgrade"
	else
		elog "Execute the following command to initlize environment:"
		elog
		elog "# cd ${EPREFIX}${REDMINE_DIR}"
		elog "# cp config/database.yml.example config/database.yml"
		elog "# \${EDITOR} config/database.yml"
		elog "# chown redmine:redmine config/database.yml"
		elog "# emerge --config \"=${CATEGORY}/${PF}\""
		elog
		elog "Installation notes are at official site"
		elog "http://www.redmine.org/wiki/redmine/RedmineInstall"
	fi
	einfo
}

pkg_config() {
	if [ ! -e "${EPREFIX}${REDMINE_DIR}/config/database.yml" ] ; then
		eerror "Copy ${EPREFIX}${REDMINE_DIR}/config/database.yml.example to ${EPREFIX}${REDMINE_DIR}/config/database.yml"
		eerror "then edit this file in order to configure your database settings for \"production\" environment."
		die
	fi

	local RAILS_ENV=${RAILS_ENV:-production}
	local RUBY=${RUBY:-ruby18}

	cd "${EPREFIX}${REDMINE_DIR}" || die
	if [ -e "${EPREFIX}${REDMINE_DIR}/config/initializers/session_store.rb" ] ; then
		einfo
		einfo "Upgrading database."
		einfo

		einfo "Migrating database."
		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate || die
		einfo "Upgrading the plugin migrations."
		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate:upgrade_plugin_migrations # || die
		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate_plugins || die
		einfo "Clear the cache and the existing sessions."
		${RUBY} -S rake tmp:cache:clear || die
		${RUBY} -S rake tmp:sessions:clear || die
	else
		einfo
		einfo "Initializing database."
		einfo

		einfo "Generating a session store secret."
		${RUBY} -S rake generate_session_store || die
		einfo "Creating the database structure."
		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate || die
		einfo "Populating database with default configuration dat."
		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake redmine:load_default_data || die
		einfo
		einfo "If you use sqlite3, please do not forget to change the ownership of the sqlite files."
		einfo
		einfo "# cd \"${EPREFIX}${REDMINE_DIR}\""
		einfo "# chown redmine:redmine db/ db/*.sqlite3"
		einfo
	fi
}
