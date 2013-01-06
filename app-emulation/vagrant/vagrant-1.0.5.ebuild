# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vagrant/vagrant-1.0.5.ebuild,v 1.1 2012/09/21 00:14:45 radhermit Exp $

EAPI="4"
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"
RUBY_FAKEGEM_GEMSPEC="vagrant.gemspec"
RUBY_FAKEGEM_EXTRAINSTALL="config keys templates"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="A tool for building and distributing virtual machines using VirtualBox"
HOMEPAGE="http://vagrantup.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE="test"

# Missing ebuild for contest
RESTRICT="test"

RDEPEND="${RDEPEND}
	!x64-macos? ( || ( app-emulation/virtualbox app-emulation/virtualbox-bin ) )"

ruby_add_rdepend "
	>=dev-ruby/archive-tar-minitar-0.5.2
	>=dev-ruby/childprocess-0.3.1
	>=dev-ruby/erubis-2.7.0
	dev-ruby/i18n:0.6
	>=dev-ruby/json-1.5.1
	>=dev-ruby/log4r-1.1.9
	>=dev-ruby/net-scp-1.0.4
	>=dev-ruby/net-ssh-2.2.2
"

ruby_add_bdepend "
	dev-ruby/rake
	test? ( dev-ruby/mocha virtual/ruby-minitest )
"

all_ruby_prepare() {
	# remove bundler support
	sed -i '/[Bb]undler/d' Rakefile || die
	rm Gemfile || die

	# loosen unslotted dependencies
	sed -i -e '/childprocess\|erubis\|json\|log4r\|net-scp\|net-ssh/s/~>/>=/' \
		-e '/archive-tar-minitar/s/=/>=/' \
		${PN}.gemspec || die

	# avoid calling git
	sed -i '/git ls-files/d' ${PN}.gemspec || die
}

pkg_postinst() {
	if use x64-macos ; then
		ewarn
		ewarn "For Mac OS X prefixes, you must install the virtualbox"
		ewarn "package specifically for OS X which can be found at:"
		ewarn "https://www.virtualbox.org/wiki/Downloads"
		ewarn
	fi
}
