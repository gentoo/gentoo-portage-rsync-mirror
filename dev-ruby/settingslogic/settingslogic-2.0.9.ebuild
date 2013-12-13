# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/settingslogic/settingslogic-2.0.9.ebuild,v 1.1 2013/12/13 04:36:45 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="A simple configuration / settings solution that uses an ERB enabled YAML file"
HOMEPAGE="http://github.com/binarylogic/settingslogic"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86 ~x86-macos"
SLOT="0"
IUSE=""

all_ruby_prepare() {
	sed -i -e '/check_dependencies/d' Rakefile || die
}
