# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/jquery-rails/jquery-rails-2.3.0.ebuild,v 1.4 2014/12/30 10:12:44 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

RUBY_FAKEGEM_EXTRAINSTALL="vendor"

RUBY_FAKEGEM_GEMSPEC="jquery-rails.gemspec"

inherit ruby-fakegem

DESCRIPTION="jQuery! For Rails! So great"
HOMEPAGE="http://www.rubyonrails.org"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos"

IUSE=""

ruby_add_rdepend ">=dev-ruby/railties-3.0 >=dev-ruby/thor-0.14"

all_ruby_prepare() {
	sed -i -e '/git ls-files/d' jquery-rails.gemspec || die
}
