# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/dbf/dbf-2.0.7.ebuild,v 1.1 2013/12/27 07:10:53 graaff Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md docs/*"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="a small fast library for reading dBase, xBase, Clipper and FoxPro
database files"
HOMEPAGE="http://github.com/infused/dbf"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

USE_RUBY="ruby18" ruby_add_rdepend ">=dev-ruby/fastercsv-1.5.5"

each_ruby_prepare() {
	# We only support fastercsv for ruby 1.8.
	case ${RUBY} in
		*/ruby18)
			;;
		*)
			sed -i -e '/fastercsv/d' ${RUBY_FAKEGEM_GEMSPEC} || die
			;;
	esac
}
