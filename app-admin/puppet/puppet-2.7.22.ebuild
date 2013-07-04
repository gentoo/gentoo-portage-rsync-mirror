# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/puppet/puppet-2.7.22.ebuild,v 1.5 2013/07/04 12:26:32 ago Exp $

EAPI="4"
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG* README*"

inherit elisp-common xemacs-elisp-common eutils ruby-fakegem user

DESCRIPTION="A system automation and configuration management software"
HOMEPAGE="http://puppetlabs.com/"
SRC_URI="http://www.puppetlabs.com/downloads/puppet/${P}.tar.gz"

LICENSE="Apache-2.0 GPL-2"
SLOT="0"
IUSE="augeas diff doc emacs ldap minimal rrdtool selinux shadow sqlite3 vim-syntax xemacs"
KEYWORDS="amd64 hppa ppc ~sparc x86"

ruby_add_rdepend "
	>=dev-ruby/facter-1.5.6
	augeas? ( dev-ruby/ruby-augeas )
	diff? ( dev-ruby/diff-lcs )
	doc? ( dev-ruby/rdoc )
	ldap? ( dev-ruby/ruby-ldap )
	shadow? ( dev-ruby/ruby-shadow )
	sqlite3? ( dev-ruby/sqlite3 )
	virtual/ruby-ssl"
#	couchdb? ( dev-ruby/couchrest )
#	mongrel? ( www-servers/mongrel )
#	rack? ( >=dev-ruby/rack-1 )
#	rails? (
#		dev-ruby/rails
#		>=dev-ruby/activerecord-2.1
#	)
#	stomp? ( dev-ruby/stomp )

DEPEND="${DEPEND}
	ruby_targets_ruby19? ( dev-lang/ruby:1.9[yaml] )
	emacs? ( virtual/emacs )
	xemacs? ( app-editors/xemacs )
	selinux? ( sec-policy/selinux-puppet )"
RDEPEND="${RDEPEND}
	ruby_targets_ruby19? ( dev-lang/ruby:1.9[yaml] )
	emacs? ( virtual/emacs )
	xemacs? ( app-editors/xemacs )
	rrdtool? ( >=net-analyzer/rrdtool-1.2.23[ruby] )
	selinux? (
		sys-libs/libselinux[ruby]
		sec-policy/selinux-puppet
	)
	>=app-portage/eix-0.18.0"

SITEFILE="50${PN}-mode-gentoo.el"

RUBY_PATCHES=(  )

pkg_setup() {
	enewgroup puppet
	enewuser puppet -1 -1 /var/lib/puppet puppet
}

all_ruby_compile() {
	all_fakegem_compile

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

each_fakegem_install() {
	${RUBY} install.rb --destdir="${D}" install
}

all_ruby_install() {
	all_fakegem_install

	newinitd "${FILESDIR}"/puppet.init-r1 puppet
	doconfd conf/gentoo/conf.d/puppet

	# Initial configuration files
	insinto /etc/puppet
	# Bug #338439
	#doins conf/gentoo/puppet/*
	doins conf/redhat/puppet.conf

	# Location of log and data files
	keepdir /var/{run,log}/puppet
	fowners -R puppet:puppet /var/{run,log}/puppet

	if use minimal ; then
		rm "${ED}/usr/bin/puppetmasterd"
		rm "${ED}/etc/puppet/auth.conf"
	else
		newinitd "${FILESDIR}"/puppetmaster.init puppetmaster
		newconfd "${FILESDIR}"/puppetmaster.confd puppetmaster

		insinto /etc/puppet
		doins conf/redhat/fileserver.conf

		keepdir /etc/puppet/manifests
		keepdir /etc/puppet/modules

		keepdir /var/lib/puppet/ssl
		keepdir /var/lib/puppet/facts
		keepdir /var/lib/puppet/files
		fowners -R puppet:puppet /var/{run,log,lib}/puppet
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

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles/ftdetect; doins ext/vim/ftdetect/puppet.vim
		insinto /usr/share/vim/vimfiles/syntax; doins ext/vim/syntax/puppet.vim
	fi

	# ext and examples files
	for f in $(find ext examples -type f) ; do
		docinto "$(dirname ${f})"; dodoc "${f}"
	done
	docinto conf; dodoc conf/namespaceauth.conf
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

	use emacs && elisp-site-regen
	use xemacs && xemacs-elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
	use xemacs && xemacs-elisp-site-regen
}
