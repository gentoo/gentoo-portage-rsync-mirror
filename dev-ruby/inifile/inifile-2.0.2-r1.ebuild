# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/inifile/inifile-2.0.2-r1.ebuild,v 1.1 2013/10/29 23:28:15 mrueg Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md History.txt"

inherit ruby-fakegem eutils

DESCRIPTION="Native Ruby package for reading and writing INI files."
HOMEPAGE="https://github.com/TwP/inifile"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

each_ruby_test() {
	${RUBY} -S testrb test/test_*.rb || die
}
