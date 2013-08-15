# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/puppet/puppet-3.2.4.ebuild,v 1.1 2013/08/15 15:43:32 prometheanfire Exp $

EAPI="4"

USE_RUBY="ruby18 ruby19"

inherit elisp-common xemacs-elisp-common eutils user ruby-ng versionator

DESCRIPTION="A system automation and configuration management software"
HOMEPAGE="http://puppetlabs.com/"
SRC_URI="http://www.puppetlabs.com/downloads/puppet/${P}.tar.gz"

LICENSE="Apache-2.0 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="augeas diff doc emacs ldap minimal rrdtool selinux shadow sqlite3 vim-syntax xemacs"

ruby_add_rdepend "
	dev-ruby/hiera
	>=dev-ruby/facter-1.6.2
	augeas? ( dev-ruby/ruby-augeas )
	diff? ( dev-ruby/diff-lcs )
	doc? ( dev-ruby/rdoc )
	ldap? ( dev-ruby/ruby-ldap )
	shadow? ( dev-ruby/ruby-shadow )
	sqlite3? ( dev-ruby/sqlite3 )
	virtual/ruby-ssl"

DEPEND="${DEPEND}
	ruby_targets_ruby19? ( dev-lang/ruby:1.9[yaml] )
	emacs? ( virtual/emacs )
	xemacs? ( app-editors/xemacs )"
RDEPEND="${RDEPEND}
	ruby_targets_ruby19? ( dev-lang/ruby:1.9[yaml] )
	rrdtool? ( >=net-analyzer/rrdtool-1.2.23[ruby] )
	selinux? (
		sys-libs/libselinux[ruby]
		sec-policy/selinux-puppet
	)
	vim-syntax? ( >=app-vim/puppet-syntax-3.0.1 )
	>=app-portage/eix-0.18.0"

SITEFILE="50${PN}-mode-gentoo.el"

RUBY_PATCHES=( "${FILESDIR}/puppet-openrc-status-fix.patch" )

pkg_setup() {
	enewgroup puppet
	enewuser puppet -1 -1 /var/lib/puppet puppet
}

all_ruby_compile() {
	if use emacs ; then
		elisp-compile ext/emacs/puppet-mode.el
	fi

	if use xemacs ; then
		# Create a separate version for xemacs to be able to install
		# emacs and xemacs in parallel.
		mkdir ext/xemacs
		cp ext/emacs/* ext/xemacs/
		xemacs-elisp-compile ext/xemacs/puppet-mode.el
	fi
}

each_ruby_install() {
	${RUBY} install.rb --destdir="${D}" install || die
}

all_ruby_install() {
	newinitd "${FILESDIR}"/puppet.init-r1 puppet

	# Initial configuration files
	insinto /etc/puppet

	# Location of log and data files
	keepdir /var/log/puppet
	fowners -R puppet:puppet /var/log/puppet

	if use minimal ; then
		rm "${ED}/etc/puppet/auth.conf"
	else
		newinitd "${FILESDIR}"/puppetmaster.init-r1 puppetmaster
		newconfd "${FILESDIR}"/puppetmaster.confd puppetmaster

		insinto /etc/puppet

		keepdir /etc/puppet/manifests
		keepdir /etc/puppet/modules

		keepdir /var/lib/puppet/ssl
		keepdir /var/lib/puppet/facts
		keepdir /var/lib/puppet/files
		fowners -R puppet:puppet /var/lib/puppet
	fi

	if use emacs ; then
		elisp-install ${PN} ext/emacs/puppet-mode.el*
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

	if use xemacs ; then
		xemacs-elisp-install ${PN} ext/xemacs/puppet-mode.el*
		xemacs-elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

	if use ldap ; then
		insinto /etc/openldap/schema; doins ext/ldap/puppet.schema
	fi

	# ext and examples files
	for f in $(find ext examples -type f) ; do
		docinto "$(dirname ${f})"; dodoc "${f}"
	done
}

pkg_postinst() {
	elog
	elog "Please, *don't* include the --ask option in EMERGE_EXTRA_OPTS as this could"
	elog "cause puppet to hang while installing packages."
	elog
	elog "Puppet uses eix to get information about currently installed packages,"
	elog "so please keep the eix metadata cache updated so puppet is able to properly"
	elog "handle package installations."
	elog
	elog "Currently puppet only supports adding and removing services to the default"
	elog "runlevel, if you want to add/remove a service from another runlevel you may"
	elog "do so using symlinking."
	elog

	if [ \
		-f "${EPREFIX}/etc/puppet/puppetd.conf" -o \
		-f "${EPREFIX}/etc/puppet/puppetmaster.conf" -o \
		-f "${EPREFIX}/etc/puppet/puppetca.conf" \
	] ; then
		elog
		elog "Please remove deprecated config files."
		elog "	/etc/puppet/puppetca.conf"
		elog "	/etc/puppet/puppetd.conf"
		elog "	/etc/puppet/puppetmasterd.conf"
		elog
	fi

	if [ "$(get_major_version $REPLACING_VERSIONS)" = "2" ]; then
		elog
		elog "If you're upgrading from 2.x then we strongly suggest you to read:"
		elog "http://docs.puppetlabs.com/guides/upgrading.html"
		elog
	fi

	use emacs && elisp-site-regen
	use xemacs && xemacs-elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
	use xemacs && xemacs-elisp-site-regen
}
