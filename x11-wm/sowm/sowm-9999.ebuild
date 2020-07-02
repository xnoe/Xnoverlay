EAPI=7

DESCRIPTION="Shitty Opinionated Window Manager"
HOMEPAGE="https://github.com/dylanaraps/sowm"
SRC_URI="https://github.com/dylanaraps/sowm/archive/master.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${CDEPEND}"
BDEPEND=""

S="${WORKDIR}/sowm-master"

PATCHES=(
	"${FILESDIR}/config.h.patch"
)

src_prepare() {
  default
  mv ${S}/config.def.h ${S}/config.h
}
